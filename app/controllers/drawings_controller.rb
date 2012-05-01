class DrawingsController < ApplicationController

  def index
    @drawings = current_user.drawings
  end

  def show
    redirect_to edit_drawing_path(params[:id])
  end

  def new
    @drawing = current_user.drawings.build
  end

  def edit
    @drawing = current_user.drawings.find(params[:id])
  end

  def create
    @drawing = current_user.drawings.build(params[:drawing])

    if @drawing.save
      redirect_to @drawing, :notice => 'Drawing was successfully created.'
    else
      render 'new'
    end
  end


  def update
    @drawing = current_user.drawings.find(params[:id])

    if @drawing.update_attributes(params[:drawing])
      redirect_to @drawing, :notice => 'Drawing was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @drawing = current_user.drawings.find(params[:id])
    @drawing.destroy
    redirect_to drawings_url
  end

end
