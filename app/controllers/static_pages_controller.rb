class StaticPagesController < ApplicationController

  include SessionsHelper
  
  def home
  end

  def profile
  end

  def follow
    current_user
    Follow.create(user_id: params[:user_id], follower_id: @current_user.id)
  end

  def unfollow
    current_user
    Follow.where(user_id: params[:user_id], follower_id: @current_user.id).destroy_all
  end
end
