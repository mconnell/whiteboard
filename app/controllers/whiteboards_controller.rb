class WhiteboardsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :index

  def index
    if user_signed_in?
      @whiteboards = current_user.whiteboards.order('updated_at DESC')
    else
      render "pages/brochure"
    end
  end

  def show
    redirect_to edit_whiteboard_path(params[:id])
  end

  def new
    @whiteboard = current_user.whiteboards.create
    redirect_to edit_whiteboard_path(@whiteboard)
  end

  def edit
    @whiteboard = current_user.whiteboards.find(params[:id])
  end

  def update
    @whiteboard = current_user.whiteboards.find(params[:id])

    if @whiteboard.update_attributes(params[:whiteboard])
      redirect_to @whiteboard, :notice => 'whiteboard was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @whiteboard = current_user.whiteboards.find(params[:id])
    @whiteboard.destroy
    redirect_to whiteboards_url
  end

end
