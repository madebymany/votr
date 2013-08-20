class SessionsController < ApplicationController

  def create
    store_previous_url!

    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to next_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to proposals_url, notice: "Signed out!"
  end

end