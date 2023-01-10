Rails.application.routes.draw do
  mount Merged::Engine => "/merged"

  get ":id" , to: "merged/view#page" , id: :id

  get :destroy_member_session , to: "merged/view#page"
end
