class IssueReaction < ActiveRecord::Base

  belongs_to :issue
  belongs_to :user
  
  validates :user_id, presence: true
  validates :issue_id, presence: true
  
  after_save :update_issue_counter
  after_destroy {|record| update_issue_counter(record.id)}
  
  scope :like, lambda {|*args|    
    is_like = args.size > 0 ? args.first : true
	if is_like
  	  where("reaction >= ?",1)
	else
  	  where("reaction <= ?",0)		  
	end
  }    

  private

  def update_issue_counter(id = nil)
	issue = id.nil? ? self.issue : Issue.find(id)	
	issue.likes = issue.reactions.sum(:reaction)
	issue.save
	logger.debug "IssueReaction: update issue #{issue.id} | likes: #{issue.likes}"
  end

end


