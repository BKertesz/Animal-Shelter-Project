require('sinatra')
require('sinatra/contrib/all')

get '/animals' do
  erb(:"animals/index")
end
