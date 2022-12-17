Rails.application.routes.draw do
  mount Merged::Engine => "/merged"

  get ":id" , to: "merged/view#view" , id: :id

end
