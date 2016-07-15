enable :sessions

helpers do
  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  #Don\t know if we will use this yet
  # def logged_in?
  #   current_user != nil
  # end

end

# Homepage (Root path)

get "/" do
  erb :index # This is the community market page
end

get "/signup" do
  erb :"/users/signup" # This will activate the signup page 
end

post "/signup" do
  user_check = User.find_by(username: params[:username])
  if params[:password] != params[:confirm_password]
    flash[:password_mismatch] = "Passwords do not match!"
    erb :"/users/signup"
  elsif user_check.nil?
    @user = User.new(
      email: params[:email],
      username: params[:username])
    @user.password = params[:password]
    @user.save!
    redirect "/"
  else
    flash[:same_username] = "Username has been taken!"
    erb :"/users/signup"
    
  end
end

get "/login" do
  erb :"/sessions/login"
end

get "/logout" do
  session.clear
  redirect "/"
end

post "/sessions" do
    @user = User.find_by(username: params[:username])
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id 
      redirect "/profile"
    else
      erb :"/sessions/login"
    end
end

get "/profile" do
  current_user
  erb :"/users/index"
end



