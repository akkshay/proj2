class LinksController < ApplicationController

  def new
    @user = User.find params[:user_id]
    @link = @user.links.build
  end

  def create
    @user = User.find params[:user_id]
    @link = @user.links.build link_params
    if @link.save
      redirect_to @link.user
    else
      render "new"
    end
  end

  def edit
    @link = Link.find params[:id]
  end

  def update
    @link = Link.find params[:id]
    if @link.update link_params
      redirect_to @link.user
    end
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end