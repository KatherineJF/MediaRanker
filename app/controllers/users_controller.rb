class UsersController < ApplicationController

  def index
    @users = User.order(:name)
  end

  def show
  id = params[:id].to_i
  @user = User.find_by(id: id)


  if @user.nil?
   render :notfound, status: :not_found
  end
end


  def create
    @user = User.new(user_params)
      if @user.save # save returns true if the database insert succeeds
        flash[:success] = 'User Created!'

    redirect_to root_path # go to the index so we can see the book in the list
  else # save failed :(
    flash.now[:danger] = 'User not created!'
    @user.errors.messages.each do |field, messages|
      flash.now[field] = messages
    end

    render :new # show the new book form view again
  end
end


private
def user_params
  return params.require(:user).permit(:name)
end

end
