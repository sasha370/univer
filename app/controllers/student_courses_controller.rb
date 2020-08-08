class StudentCoursesController < ApplicationController


  def create
    # находим нужный курс по переданному ID
    course_to_add = Course.find(params[:course_id])
    # Проверяем есть ли этот курс у пользователя?
    unless current_user.courses.include?(course_to_add)
      StudentCourse.create(course: course_to_add, student: current_user)
      flash[:notice] = " Вы успешно записались на курс: #{course_to_add.name}"
      redirect_to courses_path
    else
      flash[:notice] = " Что-то пошло не так с вашей записью"
    end
  end

  def destroy
    course_to_remove = Course.find(params[:course_id])
    if current_user.courses.include?(course_to_remove)
      student_course = StudentCourse.where(course: course_to_remove, student: current_user).first
      student_course.delete
      flash[:notice] = " Вы успешно Отписались от курса: #{course_to_remove.name}"
      redirect_to courses_path
    else
      flash[:notice] = "Что-то пошло не так"
    end
  end
end