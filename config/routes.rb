Rails.application.routes.draw do

  # Задаем главный путь, который будет обработан в контроллере course, используя метод index
  # вьюха будет находится в папке courses/index
  root 'courses#index'

  # При получении на сервере Get запроса about, перенаправить в контроллер pages, использовать экшн about
  # Вьюха также будет находится в папке pages/about
  get "about", to: 'pages#about'
  get 'courses/new', to: 'courses#new'

  # Прописываем все возможные пути для Students по CRUD, кроме удаления
  resources :students, except: [:destroy]


  # Прописываем пути для отдельных страниц. их контроллеров и экшены к ним
  get 'login', to: 'logins#new'
  post 'login', to: 'logins#create'
  delete 'logout', to: 'logins#destroy'

  # Обработчик событий при записи студента на курс
  post 'course_enroll', to: 'student_courses#create'


end
