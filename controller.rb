require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('./models/transaction')
require_relative('./models/merchant')
require_relative('./models/tag')

# Merchant routes
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

# Tag routes

get '/tag' do
  @tags = Tag.all()
  erb(:tag_index)
end

get '/tag/new' do
  erb(:tag_new)
end

get '/tag/:id' do
  @tag = Tag.find(params[:id])
  @spent_by_tag = Tag.spent_by_tag(params[:id])
  erb(:tag_show)
end

post '/tag' do
  @tag = Tag.new(params)
  @tag.save()
  erb(:tag_create)
end

get '/tag/:id/edit' do 
  @tag = Tag.find(params[:id])
  erb(:tag_edit)
end

post '/tag/:id' do
  @tag = Tag.find(params[:id])
  @tag.update(params)
  redirect to "/tag/#{params[:id]}"
end

post '/tag/:id/delete' do
  @tag = Tag.find(params[:id])
  @tag.delete()
  redirect to "/tag"
end

# Transaction routes

get '/transaction' do
  @merchants = Merchant.all()
  @tags = Tag.all()
  @transactions = Transaction.all()
  @total_spent = Transaction.total_spent()
  @warning_message = Transaction.warning()
  erb(:transaction_index)
end

get '/transaction/new' do
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:transaction_new)
end

get '/transaction/:id' do
  @transaction = Transaction.find(params[:id])
  erb(:transaction_show)
end

post '/transaction' do
  @transaction = Transaction.new(params)
  @transaction.save()
  erb(:transaction_create)
end

get '/transaction/:id/edit' do 
  @merchants = Merchant.all()
  @tags = Tag.all()
  @transaction = Transaction.find(params[:id])
  erb(:transaction_edit)
end

post '/transaction/:id' do
  @transaction = Transaction.find(params[:id])
  @transaction.update(params)
  redirect to "/transaction/#{params[:id]}"
end

post '/transaction/:id/delete' do
  @transaction = Transaction.find(params[:id])
  @transaction.delete()
  redirect to "/transaction"
end

# month routes

get '/month' do
  @months = Transaction.list_months()
  @merchants = Merchant.all()
  @tags = Tag.all()
  @transactions = Transaction.all()
  @total_spent = Transaction.total_spent()
  erb(:transaction_by_month)
end

get '/month/:month' do
  @transactions_by_month = Transaction.all_by_month(params[:month])
  @merchants = Merchant.all()
  @tags = Tag.all()
  @transactions = Transaction.all()
  @total_spent = Transaction.total_spent()
  erb(:month_show)
end
