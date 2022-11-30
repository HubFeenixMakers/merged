Merged::Engine.routes.draw do

  get "/styles/index" , to: "styles#index"
  resources :pages , shallow: true  do
    resources :sections do
      get :select_image
      get :set_image
      get :select_template
      get :set_template
      get :select_card_template
      get :set_card_template
      resources :cards do
        get :select_image
        get :set_image
      end
    end
  end
  resources :images
end
