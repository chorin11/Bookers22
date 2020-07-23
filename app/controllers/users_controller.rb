class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		@users = User.all
		@book = Book.new
		@user = current_user
	end


	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
    		redirect_to user_path(@user.id), notice: "successfully"
		else
			flash[:error] = "error"
			render "edit"
      	end
	end

	def show
		@user = User.find(params[:id])
		@books = @user.books
		@book = Book.new
	end

	def edit
		@user = current_user
		@book = Book.new
		@users = User.find(params[:id])
		if @users.id != @user.id
			redirect_to user_path(@user.id)
		else
			render "edit"
		end
	end

	private
	def user_params
  	params.require(:user).permit(:name, :profile_image)
	end

end
