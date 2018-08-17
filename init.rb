# ActiveSupport::Reloader for rails >= 5
# ActionDispatch::Callbacks for rails < 5
reloader = defined?(ActiveSupport::Reloader) ? ActiveSupport::Reloader : ActionDispatch::Callbacks
reloader.to_prepare do
  paths = '/lib/redmine_issue_reaction/{patches/*_patch,hooks/*_hook}.rb'
  Dir.glob(File.dirname(__FILE__) + paths).each do |file|
    require_dependency file
  end
end

Redmine::Plugin.register :redmine_issue_reaction do
  name 'Redmine Issue Reaction Plugin'
  url 'https://github.com/patajones/redmine_issue_reaction'
  author 'Ricardo Bernardes'
  author_url 'https://github.com/patajones/'
  description 'Add a Like Button on Issue'
  version '1.1.0'  
  
  requires_redmine :version_or_higher => '3.4.0'  

  project_module :issue_reaction do
    permission :view_detail_issues_reactions, :issues => :show	
	permission :view_resume_issues_reactions, :issues => :show	
	permission :vote_issues_reactions, :issues => :show	
  end  
end