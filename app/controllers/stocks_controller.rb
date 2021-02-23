class StocksController < ApplicationController

  def search
    if(params[:stock].present?)
        @stock = Stock.new_lookup(params[:stock])
        if(@stock)
          respond_to do |format|
            format.js { render partial: 'users/result' }
          end
        else
          respond_to do |format|
            flash.now[:alert]="Enter a valid symbol to search stock"
            format.js { render partial: 'users/result' }
          end
        end
    else
      respond_to do |format|
        flash.now[:alert]="Enter a symbol to search stock"
        format.js { render partial: 'users/result' }
      end
    end
  end

  def update
    user_id = params[:id]
    stocks = User.find(user_id).stocks
    stocks.each do |stock|
      stock.update(last_price: Stock.price(stock.ticker))
    end
    redirect_to my_portfolio_path
  end
end