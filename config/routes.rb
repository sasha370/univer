Rails.application.routes.draw do

  root 'pages#welcome'

  get "about", to: 'pages#about'

  resources :students, except: [:destroy]
  resources :courses

  get 'login', to: 'logins#new'
  post 'login', to: 'logins#create'
  delete 'logout', to: 'logins#destroy'

  post 'course_enroll', to: 'student_courses#create'
  delete 'course_enroll', to: 'student_courses#destroy'
end
