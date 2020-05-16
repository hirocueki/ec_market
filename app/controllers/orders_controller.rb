class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = current_user.orders.build do |order|
      order.build_order_items(current_cart)
      order
    end
  end

  def create
    if current_cart.empty?
      redirect_to new_order_url, alert: 'カートに商品がありません'
    end

    @order = current_user.orders.build(order_params) do |order|
      order.build_order_items(current_cart)
      order
    end

    if @order.save
      clear_current_cart
      redirect_to root_url, notice: '注文を受け付けました！'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(%i[address ship_time ship_date])
  end
end
