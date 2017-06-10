require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('./models/transaction')
require_relative('./models/merchant')
require_relative('./models/tag')

get '/merchant' do
  @merchants = Merchant.all()
  erb(:merchant_index)
end

get '/merchant/new' do
  erb(:merchant_new)
end

get '/merchant/:id' do
  @merchant = Merchant.find(params[:id])
  erb(:merchant_show)
end

post '/merchant' do
  @merchant = Merchant.new(params)
  @merchant.save()
  erb(:merchant_create)
end

get '/merchant/:id/edit' do 
  @merchant = Merchant.find(params[:id])
  erb(:merchant_edit)
end

post '/merchant/:id' do
  @merchant = Merchant.find(params[:id])
  @merchant.update(params)
  redirect to "/merchant/#{params[:id]}"
end

post '/merchant/:id/delete' do
  @merchant = Merchant.find(params[:id])
  @merchant.delete()
  redirect to "/merchant"
end


