module RedmineIssueReaction
  module Hooks
    class ViewsIssuesHook < Redmine::Hook::ViewListener     
	  render_on :view_issues_sidebar_queries_bottom, :partial => 'reactions/reactions_sidebar'
	end
  end
end
