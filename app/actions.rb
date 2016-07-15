enable :sessions

helpers do
  # def current_user
  #   @current_user ||= User.find(session[:user_id])
  # end

  def current_user
    @user = User.find(6)
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


get "/books/new" do
  erb :"/books/new"
end

get "/books" do
  @books = Book.all
  erb :"books/index"
end

post "/books" do
  @book = Book.new(
    title: params[:title],
    rating: params[:rating],
    genre: params[:genre],
    url: params[:url],
    review: params[:review])
  if @song.save
    redirect "/books"
  else
    erb :"books/new"
  end
end

get "/books/borrowed" do
  @my_books = Book.joins(:borrowed_book).where(id: current_user.id)
  # Replace magic user with current user id
  erb :"/books/borrowed"
end

# Can try and use partial for the books and borrowed pages. Almost identical

post "/books/claim" do
  #need to update the book table
  @borrowed_book = BorrowedBook.new(
    user_id: current_user.id,
    book_id: params[:book_id])
  if @borrowed_book.save!
    Book.find(params[:book_id]).update(available: false)
    redirect "/books"
  else
    flash.now[:claim_error] = "Something went wrong!"
    erb :"/books"
  end
end

get '/market' do
  @posts = Post.all.order("created_at DESC")
  erb :"/market"
end
