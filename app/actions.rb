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
      redirect "/books"
    else
      erb :"/"
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
  @button_name = "Claim"

  # If you ever change the ones below, please update /books/borrowed route
  ratings = Post.group(:book_id)
  @review_count = ratings.count
  @avg_ratings = ratings.average(:rating)
  @avg_ratings
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
  redirect "/books"
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
  @my_books_borrowed = BorrowedBook.where(user_id: current_user.id)
  @my_books_borrowed_count=@my_books_borrowed.count
  @my_books_borrowed_hash = BorrowedBook.joins(:book).where(user_id: current_user.id)
  @books = Book.all
  @button_name = "Re-Upload"

  ratings = Post.group(:book_id)
  @review_count = ratings.count
  @avg_ratings = ratings.average(:rating)
  @avg_ratings

  #if @my_books_borrowed.empty?
   # redirect "/books"
  #else
    # @my_books_borrowed_count = @my_books_borrowed.count

    # top_rated = current_user.posts.maximum(:rating)

    # unless top_rated.nil?
    #   @max_rated = current_user.posts.find_by(rating: top_rated)
    #   @max_rated_book = Book.find(@max_rated.book_id)
    #   @max_rated_book_url = @max_rated_book.pictures.last.url
    # end

    #Code refactor

    @posts = Post.joins(:user)
    posts_hash = {}
    @posts_rating = []
    @posts.each do |post|
      if post[:rating]
      posts_hash[post[:rating]] = post[:book_id]
      @posts_rating << post[:rating]
      @posts_rating.delete(nil)
      end
    end

    @max_rating = @posts_rating.max
    @max_rating_book_id = posts_hash[@max_rating]
    @max_rated_book = Book.find(@max_rating_book_id).title
    @max_rated_book_url = Picture.find_by(book_id: @max_rating_book_id).url

    erb :"/books/borrowed"
  #end
end
# Can try and use partial for the books and borrowed pages. Almost identical

post "/books/claim/:book_id" do
  can_borrow = Book.find(params[:book_id]).available
  if can_borrow
    #need to update the book table
    @borrowed_book = BorrowedBook.create(
      user_id: current_user.id,
      book_id: params[:book_id])
      Book.find(params[:book_id]).update(available: false)
      redirect "/books/borrowed"
  else
      flash.now[:claim_error] = "This book is already borrowed!"
      redirect "/books"
  end
end

get "/books/:id" do
  @book = Book.find(params[:id])
  ratings = @book.posts
  unless ratings.nil?
    @review_count = ratings.count
    @avg_ratings = ratings.average(:rating)
  end
  erb :"books/show"
end

post "/books/reupload/:id" do
  BorrowedBook.find_by(book_id: params[:id]).delete
  Book.find(params[:id]).update(available: true)
  Post.create(
    user_id: current_user.id,
    book_id: params[:id],
    rating: params[:rating],
    review: params[:review]
    )
  Picture.create(
    url: params[:url],
    book_id: params[:id])
  redirect "/books/borrowed"
end
