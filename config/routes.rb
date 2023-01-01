Merged::Engine.routes.draw do

  get  'changes/index'
  post 'changes/commit'
  post 'changes/reset'
  get "styles/index"

  post 'form/sendit'

  resources :pages , except: [:edit , :new] , shallow: true  do
    resources :sections do
      get :set_image
      get :select_template
      get :set_template
      get :select_card_template
      get :set_card_template
      get :move
      resources :cards do
        get :set_image
        get :move
      end
    end
  end
  resources :images do
    get :copy
    post :crop
    post :scale
  end
end
