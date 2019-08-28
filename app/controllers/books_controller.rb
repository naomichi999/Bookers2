class BooksController < ApplicationController
  before_action :authenticate_user!


  def index
  	@book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
     @book = Book.find(params[:id])
     if current_user != @book.user
      redirect_to books_path
    else
      render :edit
    end
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # ↑ログインしていないと持ってこれない
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] = "You have creatad book successfully."
    else
      render :index
      # createアクションのrenderからindexに飛ぶと、
      # そのindexページが呼び出すアクションはcreateに
      # なるので、@booksを新しく定義した。
      flash[:notice] = "error"
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:notice] = "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  protected
    def book_params
      params.require(:book).permit(:title, :body)
    end
end
