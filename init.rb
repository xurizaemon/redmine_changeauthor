require 'redmine'

require_dependency 'redmine_changeauthor/hooks'

Redmine::Plugin.register :redmine_changeauthor do

  name 'Redmine ChangeAuthor plugin'
  author 'Tom Stark @fragtom'
  description 'Plugin for author change'
  version '1.0.0' 
  settings :default => {'redmine_changeauthor_log_setting' => '0'}, :partial => 'settings/redmine_changeauthor_settings'
  
  project_module :issue_tracking do
    permission :change_author, :require => :member
  end
end

