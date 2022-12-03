Merged::Engine.routes.draw do

  get  'changes/index'
  post 'changes/commit'
  get "styles/index"

  resources :pages , except: [:show] , shallow: true  do
    resources :sections do
      get :select_image
      get :set_image
      get :select_template
      get :set_template
      get :select_card_template
      get :set_card_template
      get :move
      get :remove
      resources :cards do
        get :select_image
        get :set_image
        get :move
        get :remove
      end
    end
    get :remove
  end
  resources :images do
    get :remove
  end
end
