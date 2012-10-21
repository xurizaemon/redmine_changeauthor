RedmineApp::Application.routes.draw do
  get '/changeauthor/index' => 'changeauthor#index'
  post '/changeauthor/edit' => 'changeauthor#edit'
end
