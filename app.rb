# App.rb
require 'sinatra'
require 'sinatra/activerecord'
require 'roar/representer/json'
require 'roar/representer/json/hal'

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == 'admin' and password == 'admin'
end

set :database, 'sqlite3:todolist.db'

class Todo < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 3 }
  validates :body, presence: true
end

module TodoRepresenter  
  include Roar::Representer::JSON
  include Roar::Representer::JSON::HAL

  link :self do
     {"href" => "/todos/#{id}"}
  end

  property :id
  property :title
  property :body
  property :created_at
  property :updated_at  
end

get '/' do
  @pagetitle = "Niet Blendle"
  @todos = Todo.order('created_at DESC')
  @todos.to_json    
  erb :'todos/index'
end

get '/todos/new' do
  @pagetitle = 'New Todo'
  @todo = Todo.new
  erb :'todos/new'
end

post "/todos" do
  @todo = Todo.new(params[:todo])
  if @todo.save
    redirect "/"
  else
    erb :"todos/new"
  end
end

get '/todos/:id' do
  @todo = Todo.find(params[:id])
  @todo.extend(TodoRepresenter)
  @todo.to_json
end

get '/todos/:id/edit' do
  @todo = Todo.find(params[:id])
  @pagetitle = 'Edit Form'
  erb :'todos/edit'
end
 
put "/todos/:id" do
  @todo = Todo.find(params[:id])
  if @todo.update_attributes(params[:todo])
    redirect "/"
  else
    erb :"todos/edit"
  end
end
 
delete '/todos/:id' do
  @todo = Todo.find(params[:id]).destroy
  redirect '/'
end

get '/about' do   
  @pagetitle = 'About Me'
  erb :'pages/about'
end

helpers do
  def pagetitle
    if @pagetitle
      '#{@pagetitle} -- My Todolist'
    else
      'My Todolist'
    end
  end

  def pretty_date(time)
  time.strftime('%d %b %Y')
  end

  def todo_show_page?
  request.path_info =~ /\/todos\/\d+$/
  end

  def delete_todo_button(todo_id)
    erb :_delete_todo_button, locals: { todo_id: todo_id}
  end
end