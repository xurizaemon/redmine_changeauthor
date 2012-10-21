module RedmineChangeauthor
  class Hooks < Redmine::Hook::ViewListener
    include Redmine::I18n

    render_on :view_issues_form_details_bottom, :partial => 'issues/changeauthor'
  end
end
