class ReactionsController < ApplicationController
  unloadable


  def vote    
    @issue = Issue.find(params[:issue_id])
	@project = @issue.project
    if User.current.allowed_to?(:vote_issues_reactions, @project)
   	  user = User.current
	  
	  issue_reaction = IssueReaction.find_by(user: user, issue: @issue)
	  issue_reaction = @issue.reactions.create(user: user, issue: @issue) if issue_reaction.nil?
	  issue_reaction.reaction = params[:reaction]
	  issue_reaction.save

      respond_to do |format|
        format.html { redirect_to_referer_or {render :text => 'Reactions Voted.', :layout => true}}
        format.js { }
        format.api { render_api_ok }
      end
	end  
  end
  
end
