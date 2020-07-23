class BooksController < ApplicationController
	before_action :authenticate_user!

	def home
	end

	def create
		@books = Book.all
		@book = Book.new(book_params)
		@user = current_user
		@book.user_id = current_user.id
		if @book.save
			redirect_to book_path(@book.id), notice:"successfully"
		else
			flash[:error] = "error"
			render "index"
    	end
	end

	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
	end

	def show
		@books = Book.new
		@book = Book.find(params[:id])
		@users = User.all
		@user = @book.user
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user.id != current_user.id
			redirect_to books_path
		else
			render "edit"
		end
	end

	def update
		@book = Book.find(params[:id])
    	if @book.update(book_params)
    		redirect_to book_path(@book.id), notice: "successfully"
		else
			flash[:error] = "error"
			render "edit"
      	end
	end

	def destroy
		@book = Book.find(params[:id])
  		@book.destroy
 		redirect_to books_path
	end

	private

	def book_params
		params.require(:book).permit(:title, :body)
	end

end
