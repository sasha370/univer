class CoursesController < ApplicationController
  skip_before_action :require_user, only: [:index, :show]
  # before_action :is_admin?, only: [:new, :create, :update, :destroy]

  # TODO
  # cltkfnm? чтобы создавать мог только админ

  def index
    @courses = Course.all
  end


  def show
    @course = Course.find(params[:id])
  end

  def new
    if current_user.is_admin?
      @course = Course.new
    else
      flash[:notice] = "Только администратор сожет создавать новые курсы"
      redirect_to courses_path
    end
  end

  def create
    if current_user.is_admin?
      @course = Course.new(permit_params)
      if @course.save
        flash[:notice] = "Курс успешно создан"
        redirect_to courses_path
      else
        flash[:notice] = "У вас есть ошибки, перепроверьте"
        render :new
      end
    else
      flash[:notice] = " Только администратор сожет создавать новые курсы"
      redirect_to courses_path
    end
  end


  # Проверяем админ ли пользователь? Возвращает true /false
  # def is_admin?
  #   current_user.admin
  # end

  private

  def permit_params
    params.require(:course).permit(:short_name, :name, :description)
  end


end
