# App.rb
require 'sinatra'
require 'sinatra/activerecord'
require 'roar/representer/json'
require 'roar/representer/json/hal'
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
end

delete '/cards/:id' do
  @card = Card.find(params[:id]).destroy
  redirect '/'
end

get '/preferences' do
  erb :'pages/preferences'
end

helpers do
  def card_show_page?
    request.path_info =~ /\/cards\/\d+$/
  end

  def delete_card_button(card_id)
    erb :_delete_card_button, locals: { card_id: card_id}
  end
end
