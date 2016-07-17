require 'pry'
enable :sessions

helpers do
  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  # def current_user
  #   @user = User.find(7)
  # end
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

get '/login' do
  erb :'sessions/login'
end

post '/login' do
  @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/books'
    else
      flash[:login_notice] = "username does not exist or incorrect password!"
       erb :'session/login'
    end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/' 
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
  ratings = Post.group(:book_id)
  @review_count = ratings.count
  @avg_ratings = ratings.average(:rating)
  erb :"books/index"
end

post "/books" do
  @book = Book.new(
    title: params[:title],
    author: params[:author],
    user_id: current_user.id,
    genre: params[:genre])
  @book.save
  @post = Post.new(
    rating: params[:rating],
    review: params[:review],
    book_id: @book.id,
    user_id: current_user.id)
  @post.save
  @picture = Picture.new(
    url: params[:url],
    book_id: @book.id)
  @picture.save
  current_user[:books_contributed] += 1
  current_user.save
  redirect "/profile"
end

# get "/books/borrowed" do
#   @my_books = Book.joins(:borrowed_book).where(user_id: current_user.id)
#   @my_book_count =@my_books.count
#   # Replace magic user with current user id
#   erb :"/books/borrowed"
# end

get "/books/borrowed" do
  @user_email = current_user.email
  @my_shared_books = current_user.books_contributed
  @my_books_borrowed = Book.joins(:borrowed_book).where(id: current_user.id)
  @my_books_borrowed_count = @my_books_borrowed.count

  top_rated = current_user.posts.maximum(:rating)
  @max_rated = current_user.posts.find_by(rating: top_rated)
  @max_rated_book = Book.find(@max_rated.book_id)
  @max_rated_book_url = @max_rated_book.pictures.last.url

  #Code refactor

  # @posts = Post.joins(:user)
  # posts_hash = {}
  # @posts_rating = []
  # @posts.each do |post|
  #   if post[:rating]
  #   posts_hash[post[:rating]] = post[:book_id]
  #   @posts_rating << post[:rating]
  #   @posts_rating.delete(nil)
  #   end
  # end

  # @max_rating = @posts_rating.max
  # @max_rating_book_id = posts_hash[@max_rating]
  # @max_rated_book = Book.find(@max_rating_book_id).title
  # @max_rated_book_url = Picture.find_by(book_id: @max_rating_book_id).url

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

get "/books/:id" do
  p params[:id]
  @book = Book.find(params[:id])
  erb :"books/show"
end

get '/market' do
  @posts = Post.all.order("created_at DESC")
  erb :"/market"
end

get '/form' do 
  erb :"/form"
end
