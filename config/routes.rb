Merged::Engine.routes.draw do

  get "/styles/index" , to: "styles#index"
  resources :pages do
    resources :sections do
      get :select_image
      get :set_image
      get :select_template
      get :set_template
    end
  end
  resources :images
end
