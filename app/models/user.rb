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

  def is_friend?(friend_id)
    
    self.friends.where(id: friend_id).exists?

  end

  def self.search(friend)
    friend.strip
    value=(matches('email',friend)+matches('first_name',friend)+matches('last_name',friend)).uniq
    if value==nil
      return nil
    else
      return value
    end
  end

  def self.matches(column_name,friend)
    where("#{column_name} like ?", "%#{friend}%")
  end

  def except_current_user(friends)
    #friends.delete(self)
    friends.reject {|friend| friend.id == self.id }
  end
end