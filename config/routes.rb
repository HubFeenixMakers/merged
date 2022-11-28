Merged::Engine.routes.draw do

  resources :pages do
    resources :sections do
      get :select_image
      get :set_image
    end
  end
  resources :images
end
