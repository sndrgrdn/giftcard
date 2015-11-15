# App.rb
require 'sinatra'
require 'sinatra/activerecord'
require 'nokogiri'
require 'rest_client'

set :database, 'sqlite3:giftcard.db'

class Card < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3 }
  validates :value, presence: true
end

class Company < ActiveRecord::Base; validates :name, uniqueness: true end

get '/cards' do
  @cards = Card.order('created_at DESC')
  erb :'cards/index'
end

get '/cards/new' do
  @card = Card.new
  erb :'cards/new'
end

post '/cards' do
  @company = Company.where(name: params[:card][:name])
  req_url = @company.first.url
  code = params[:card][:code]
  scnd_code = params[:card][:scnd_code]
  response = RestClient.post(
    req_url,
    CartId: code,
    PIN: scnd_code
  ) if code && !req_url.empty?

  ## TODO: get value from response
  params['card']['value'] = response.to_f
  @card = Card.new(params[:card])
  if @card.save
    redirect 'cards'
  else
    erb :'cards/new'
  end
end

get '/cards/new' do
  @card = Card.new
  erb :'cards/new'
end

get '/cards/:id' do
  @card = Card.find(params[:id])
  path = Pathname(Dir.pwd)
  company = Company.where(name: @card.name.downcase).first
  xml = path.children.find{|n| n.extname == '.xml' && n.basename.to_s.include?(company.name)}
  products = Nokogiri::XML(xml.read).css(company.product)
  product_prices = products.map{|n| [n.at(company.product_id).text, n.at(company.price).text.to_f]}
  max_price = @card.value == 0.0 ? 10 * 1.7 : @card.value * 1.7
  matches = product_prices.find_all{|n| n[1] < max_price && n[1] > @card.value}.sample(3)
  match_products = matches.flat_map{|n| products.find{|x| x.at(company.product_id).text == n[0]}}
  @products = match_products.map{|n| [n.at(company.product_title).text, n.at(company.image).text, n.at(company.price).text, n.at(company.product_url).text]}
  erb :'cards/show'
end

patch '/cards/:id' do
  card = Card.find(params[:id])
  price = params[:price]
  card_value = card.value - price
  card_value = 0 if card_value < 0
  card.update(value: card_value)
  redirect 'cards'
  erb :'card/item'
end

helpers do
  def card_show_page?
    request.path_info =~ /\/cards\/\d+$/
  end
end
