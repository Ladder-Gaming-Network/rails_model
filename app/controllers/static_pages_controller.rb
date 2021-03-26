class StaticPagesController < ApplicationController
  def home
  end

  def profile
  end

  def follow
    puts("Button pressed!")
    Follow.create(user_id: 1, follower_id: 2)
  end
end
