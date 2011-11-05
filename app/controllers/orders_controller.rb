class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.xml
  def index

    @orders= Order.find( :all)
                                   

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new

   @cart = current_cart
if @cart.line_items.empty?
redirect_to store_url, :notice => "Your cart is empty"
return
end
@order = Order.new


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])
@order.add_line_items_from_cart(current_cart)
respond_to do |format|
if @order.save
Cart.destroy(session[:cart_id])
session[:cart_id] = nil
format.html { redirect_to({:controller=>"store",:action=>"index"}, :notice =>
'Thank you for your order.') }
format.xml { render :xml => @order, :status => :created,
:location => @order }
else
format.html { render :action => "new" }
format.xml { render :xml => @order.errors,
:status => :unprocessable_entity }
end
end

  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
end
