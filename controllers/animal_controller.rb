require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/animal')

get '/animals' do
  @animals = Animal.all
  erb(:"animals/index")
end

get '/animals/new' do
  erb(:"animals/new")
end

post '/animals' do
  animal = Animal.new(params)
  animal.save
  redirect to '/animals'
end

get '/animals/:id' do
  @animal = Animal.find_by_id(params['id'].to_i)
  erb(:'animals/show')
end

get '/animals/:id/edit' do
  @animal = Animal.find_by_id(params['id'].to_i)
  @animal.update
  erb(:'animals/edit')
end

post '/animals:id' do
  animal = Animal.new(params)
  animal.update
  redirect to ('/owners')
end

post '/animals/:id/delete' do
  Animal.delete_by_id(params['id'])
  redirect to ('/animals')
end
