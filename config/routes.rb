RedmineApp::Application.routes.draw do
  post 'issues/:issue_id/reactions/vote', :to => 'reactions#vote'
end
