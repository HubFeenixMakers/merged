Rails.application.routes.draw do
  mount Merged::Engine => "/merged"

  get ":id" , to: "merged/view#page" , id: :id

end
