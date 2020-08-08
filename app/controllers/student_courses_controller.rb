class StudentCoursesController < ApplicationController


  def create
    # находим нужный курс по переданному ID
    course_to_add = Course.find(params[:course_id])
    # Проверяем есть ли этот курс у пользователя?
    unless current_user.courses.include?(course_to_add)
      StudentCourse.create(course: course_to_add, student: current_user)
      flash[:notice] =  " Вы успешно записались на курс: #{course_to_add.name}"
      redirect_to current_user

    else
      flash[:notice] =  " Что-то пошло не так с вашей записью"
    end

  end
end