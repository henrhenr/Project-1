require 'sinatra'
require './boot.rb'
require './money_calculator.rb'

# ROUTES FOR ADMIN SECTION
get '/admin' do
  @products = Item.all
  erb :admin_index
end

get '/new_product' do
  @product = Item.new
  erb :product_form
end

post '/create_product' do
	@item = Item.new
	@item.name = params[:name]
	@item.price = params[:price].to_i
	@item.quantity = params[:quantity].to_i
	@item.sold = 0
	@item.save
 	redirect to '/admin'
end

get '/edit_product/:id' do
  @product = Item.find(params[:id])
  erb :product_form
end

post '/update_product/:id' do
  @product = Item.find(params[:id])
  @product.update_attributes!(
    name: params[:name],
    price: params[:price].to_i,
    quantity: params[:quantity].to_i,
  )
  redirect to '/admin'
end

get '/delete_product/:id' do
  @product = Item.find(params[:id])
  @product.destroy!
  redirect to '/admin'
end

get '/' do
  @products = Item.all
  erb :index
end

get '/about' do
  erb :about
end

get '/order/:id' do
  @product = Item.find(params[:id])
  erb :purchase_form
end

post '/sell/:id' do
  @product = Item.find(params[:id])
  @total_amount = params[:quantity].to_i * @product.price.to_i
  @ordered_amount = params[:quantity].to_i
  @name = @product.name
  erb :purchase_page
end

post '/transaction/:id/:quantity' do
  @product = Item.find(params[:id])
  @amount_due = params[:quantity].to_i * @product.price.to_i
  @quant = params[:quantity].to_i
  @compute = MoneyCalculator.new(params[:ones], params[:fives], params[:tens], params[:twenties], params[:fifties], params[:hundreds], params[:five_hundreds], params[:thousands])
  if (@ordered_amount.to_i > @quant || @amount_due > @compute.total.to_i || @quant > @product.quantity)
    erb :fail_page
  else
    @compute.change(@amount_due)
    @product.update_attributes!(
    quantity: (@product.quantity - params[:quantity].to_i),
    sold: (@product.sold + params[:quantity].to_i)
    )
    erb :correct_page
  end
end


get '/products' do
  @products = Item.all
  erb :products_page
end

# ROUTES FOR ADMIN SECTION
