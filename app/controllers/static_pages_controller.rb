class StaticPagesController < ApplicationController
  def home
  end

  def profile
  end

  def follow
    Follow.create(user_id: params[:user_id], follower_id: 1)
  end

  def unfollow
    Follow.where(user_id: params[:user_id], follower_id: 1).destroy_all
  end
end
