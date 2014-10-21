require 'redmine'

Redmine::Plugin.register :redmine_changeauthor do
  name 'Redmine ChangeAuthor plugin'
  author 'Tom Stark @fragtom, Stephane Lapie @ASAHI Net'
  description 'Plugin for author change'
  version '1.0.1'
  requires_redmine :version_or_higher => '2.0.0'

  settings :default => {'redmine_changeauthor_log_setting' => 'no'}, :partial => 'settings/redmine_changeauthor_settings'

  project_module :issue_tracking do
    permission :change_author, {:changeauthor => [:update, :edit]}, :require => :member
  end
end

RedmineApp::Application.config.after_initialize do
  require_dependency 'redmine_changeauthor/infectors'
end

require_dependency 'redmine_changeauthor/hooks'