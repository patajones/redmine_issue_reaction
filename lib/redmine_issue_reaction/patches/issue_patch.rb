module RedmineIssueReactions
  module Patches
    module IssuePatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
          has_many :reactions, class_name: "IssueReaction", :dependent => :delete_all		  
        end
      end

      module InstanceMethods
	    def liked? (user)
		  raise "argument needs to be a User" unless user.class == User
		  issue_reaction = self.reactions.like.where(user: user).first
          issue_reaction.nil? ? false : issue_reaction.reaction > 0
		end		
      end
    end

  end
end

unless Issue.included_modules.include?(RedmineIssueReactions::Patches::IssuePatch)
  Issue.send(:include, RedmineIssueReactions::Patches::IssuePatch)    
end
