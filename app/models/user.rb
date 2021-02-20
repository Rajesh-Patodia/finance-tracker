class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks , through: :user_stocks
  has_many :friendships
  has_many :friends , through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  def is_tracking?(ticker_symbol)
    stocks.where(ticker: ticker_symbol).first.present?
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end
end