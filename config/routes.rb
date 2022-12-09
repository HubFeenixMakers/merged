Merged::Engine.routes.draw do

  get  'changes/index'
  post 'changes/commit'
  get "styles/index"

  post 'form/sendit'

  resources :pages , except: [:show , :new] , shallow: true  do
    resources :sections do
      get :select_image
      get :set_image
      get :select_template
      get :set_template
      get :select_card_template
      get :set_card_template
      get :move
      resources :cards do
        get :select_image
        get :set_image
        get :move
      end
    end
  end
  resources :images
end
