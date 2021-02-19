class UserStocksController < ApplicationController

  def create
    stock_ticker = params[:ticker]
    stock = Stock.find_db(stock_ticker)
    if(!stock.present?)
      stock = Stock.new_lookup(stock_ticker)
      stock.save
    end
     @user_stock = UserStock.create(user: current_user, stock: stock)
     flash[:notice]=  "Stock #{stock.name} was successfully added to your portfolio"
     redirect_to my_portfolio_path
  end
end
