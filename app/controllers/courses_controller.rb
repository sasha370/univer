class CoursesController < ApplicationController
  skip_before_action :require_user



  def index
    @courses = Course.all
  end


  def new
    @course = Course.new
  end

  def show
        @course = Course.find(params[:id])
  end

  def create
    @course = Course.new(permit_params)
    if @course.save
      flash[:notice] = "Rehc успешно создан"
      redirect_to courses_path
    else
      flash[:notice] = "У вас есть ошибки, перепроверьте"
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end


  private

  def permit_params
    params.require(:course).permit(:short_name, :name, :description)
  end
end
