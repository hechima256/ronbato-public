Rails.application.routes.draw do
    devise_for :users
    # TopicsController
	resources :topics, only: [:index, :new, :create, :show] do
		# StatesController
		resources :states, only: [:show]
	end
	post "/topics/:topic_id/states/:id" => "states#create"

    #Homecontroller
	root to: 'home#top'
	get "terms" => "home#terms"
    # get "/usage" => "home#usage"
end
