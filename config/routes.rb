Rails.application.routes.draw do
  # url => action
  get "users/login" =>"users#login_form"
  post "users/login" =>"users#login"
  get "users/logout" =>"users#logout"
  get "students/index" =>"students#index"
  get "students/search" =>"students#search"
  get "students/new" =>"students#new"
  post "students/create" =>"students#create"
  get "students/:id" =>"students#show"
  get "students/:id/test/:year" =>"students#test"
  get "students/:id/edit" =>"students#edit"
  post "students/:id/update" =>"students#update"
  post "students/:id/destroy" =>"students#destroy"




  get "/" => "application#top"
end
