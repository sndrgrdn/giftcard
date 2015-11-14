# App.rb
require 'sinatra'
require 'sinatra/activerecord'
require 'nokogiri'

set :database, 'sqlite3:giftcard.db'

class Card < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3 }
  validates :value, presence: true
end

get '/cards' do
  @cards = Card.order('created_at DESC')
  erb :'cards/index'
end

post '/cards' do
  @card = Card.new(params[:todo])
  if @card.save
    redirect 'cards:id'
  else
    erb :'card/new'
  end
end

get '/cards/:id' do
  @card = Card.find(params[:id])
  erb :'card/item'
end

helpers do
  def card_show_page?
    request.path_info =~ /\/cards\/\d+$/
  end
end
