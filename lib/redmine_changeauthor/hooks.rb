module RedmineChangeauthor
  class Hooks < Redmine::Hook::ViewListener
    include Redmine::I18n

    render_on :view_issues_form_details_bottom, :partial => 'issues/changeauthor'

    def controller_redmine_changeauthor_edit_after_save context
      return if Setting['plugin_redmine_changeauthor']['redmine_changeauthor_log_setting'] == 'no'
      issue = context[:issue]
      old_author = context[:old_author]
      new_author = context[:new_author]

      journal = issue.init_journal(User.current, l(:text_journal_changed, :label => l(:field_author), :old => old_author, :new => new_author).html_safe)
      journal.save
    end
  end
end
