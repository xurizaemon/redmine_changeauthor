RedmineApp::Application.routes.draw do
  get '/changeauthor/:id/edit' => 'changeauthor#edit', :as => 'edit_changeauthor'
  put '/changeauthor/:id/update' => 'changeauthor#update', :as => 'changeauthor'
end
