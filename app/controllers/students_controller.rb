class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end


  def create
    @student = Student.new(student_params )
    if @student.save
      flash[:notice] = "Вы успешно зарегистрировлись"
      redirect_to root_path
    else
      flash[:error] =  "Что-то пошло не так"
      render :new
    end
  end


  private

  def student_params
    params.require(:student).permit(:name, :email)
  end
end