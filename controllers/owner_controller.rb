require('sinatra')
require('sinatra/contrib/all')

get "/owners" do
  erb(:"owners/index")
end
