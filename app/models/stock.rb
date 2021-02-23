class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users , through: :user_stocks

  validates :name, :ticker, presence: true
  
  
  def self.new_lookup(ticker)
    client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:sandbox_token],
                                  secret_token: Rails.application.credentials.iex_client[:secret_token],
                                  endpoint: 'https://sandbox.iexapis.com/v1')
    begin
      new(ticker: ticker,name: client.company(ticker).company_name,last_price: client.price(ticker))
    rescue=>exception
      return nil
    end
    # return client.price(ticker)
  end
  def self.price(ticker)
    client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:sandbox_token],
                                  secret_token: Rails.application.credentials.iex_client[:secret_token],
                                  endpoint: 'https://sandbox.iexapis.com/v1')
      client.price(ticker)
  end
  def self.find_db(ticker)
    where(ticker: ticker).first
  end
end
