class FriendshipsController < ApplicationController
  def create
    friend_id = params[:friend_id]
    user_id = params[:user]
    Friendship.create(user_id: user_id,friend_id: friend_id)
    flash[:notice]= "Added in your friends list"
    redirect_to my_friends_path
  end

  def destroy
    friend_id = params[:id]
    friend = current_user.friendships.where(friend_id: friend_id).first
    friend.destroy
    flash[:notice] = "You have successfully unfollowed"
    redirect_to my_friends_path
  end
end
