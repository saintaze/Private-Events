module SessionsHelper

  def login(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if id = session[:user_id]
      @current_user ||= User.find_by(id: id)
    else id = cookies.signed[:user_id]
      @user = User.find_by(id: id)
      if @user && @user.authenticated?(cookies[:remember_token])
        login @user
        @current_user = @user
      end
    end
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def logged_in?
    !!current_user
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Login to read or create secrets!"
      redirect_to login_url
    end
  end


end
