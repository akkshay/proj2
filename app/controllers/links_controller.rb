class LinksController < ApplicationController

  def new
    @user = User.find params[:user_id]
    @link = Link.new
  end

  def create
    @user = User.find params[:user_id]
    @link = Link.create(link_params)
    @link.user_id = params[:user_id]
    @link.points = 0
    if @link.save!
      render "new"
    else
      render "new"
    end
  end

  def send_link
    @link = Link.find(params[:link_id])
    @users = User.all
    user_id=0
    @users.each do |u|
      if u.name == params[:user_name]
        user_id = u.id
        break
      end
    end  
    @user = User.find(params[:sender_id])
    if not @link.receivers
      @link.receivers =[]
    end
    if not @user.received
      @user.received = []
    end
    @link.receivers.push([user_id, params[:sender_id]])
    @user.received.push(params[:link_id])
    @link.points = @link.points + 10
    if @link.save
      redirect_to root_path
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