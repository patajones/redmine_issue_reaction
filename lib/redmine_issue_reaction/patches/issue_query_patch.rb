module RedmineIssueReactions
  module Patches
    module IssueQueryPatch
      def self.included(base)
        base.send :include, InstanceMethods
        base.class_eval do
          unloadable
		  
          alias_method_chain :available_filters, :reaction
		  alias_method_chain :available_columns, :reaction
        end
      end

      module InstanceMethods
		def available_filters_with_reaction
			unless @available_filters
				available_filters_without_reaction
				if project && ((User.current.allowed_to?(:view_resume_issues_reactions, project)) || (User.current.allowed_to?(:view_detail_issues_reactions, project)))
					add_available_filter('likes', :type => :integer, :name => l(:field_likes)) if !available_filters_without_reaction.key?('likes')
				end
			end
			@available_filters
        end   

		def available_columns_with_reaction		    
			return @available_columns if @available_columns
			available_columns_without_reaction
			if project && ((User.current.allowed_to?(:view_resume_issues_reactions, project)) || (User.current.allowed_to?(:view_detail_issues_reactions, project)))
			  @available_columns << QueryColumn.new(:likes, :sortable => "#{Issue.table_name}.likes", :default_order => 'desc') 
			end
			@available_columns
		end
	  end
    end
  end
end

IssueQuery.send(:include, RedmineIssueReactions::Patches::IssueQueryPatch) unless IssueQuery.included_modules.include?(RedmineIssueReactions::Patches::IssueQueryPatch)