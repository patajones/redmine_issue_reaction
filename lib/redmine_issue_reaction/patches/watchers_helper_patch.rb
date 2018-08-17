module RedmineIssueReactions
	module Patches
		module WatchersHelperPatch
			def self.included(base)
				base.send(:include, InstanceMethods)

				base.class_eval do
					unloadable
					alias_method_chain :watcher_link, :reaction
				end
			end

			module InstanceMethods				
				def watcher_link_with_reaction(objects, user)
					content = watcher_link_without_reaction(objects, user)					
					content << render(partial: "reactions/reaction_link") if objects.present? && objects.class == Issue
					content.html_safe					
				end
			end	
		end
	end
end

unless WatchersHelper.included_modules.include?(RedmineIssueReactions::Patches::WatchersHelperPatch)
  WatchersHelper.send(:include, RedmineIssueReactions::Patches::WatchersHelperPatch)
end
