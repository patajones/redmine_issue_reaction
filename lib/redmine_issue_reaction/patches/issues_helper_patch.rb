module RedmineIssueReactions
  module Patches
    module IssuesHelperPatch
      def self.included(base)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

        end
      end

      module InstanceMethods
    	def reactions_list(issue)
    	  content = ''.html_safe		  
          issue.reactions.like.collect do |reaction| 
    	    user = reaction.user
    		s = link_to h(user.name(:username)), user_path(user), :class => user.css_classes	        
    		if s.present?
    		  s << (" "+image_tag("like.png", size: "12x12", plugin: "redmine_issue_reaction")).html_safe
    		  content << ', ' if content.present?
    		  content << content_tag('span', s, :title => h(user.name))			  
    		end
          end if User.current.allowed_to?(:view_detail_issues_reactions, @project)
    	  content	      
        end	    
      end
    end
  end
end

unless ApplicationHelper.included_modules.include?(RedmineIssueReactions::Patches::IssuesHelperPatch)
  ApplicationHelper.send(:include, RedmineIssueReactions::Patches::IssuesHelperPatch)
end
