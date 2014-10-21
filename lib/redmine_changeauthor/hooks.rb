module RedmineChangeauthor
  class Hooks < Redmine::Hook::ViewListener
    include Redmine::I18n

    render_on :view_issues_form_details_bottom, :partial => 'issues/changeauthor'

    def controller_redmine_changeauthor_edit_after_save context
      return if Setting['plugin_redmine_changeauthor']['redmine_changeauthor_log_setting'] == 'no'
      issue = context[:issue]
      old_author = context[:old_author]
      new_author = context[:new_author]

      journal = issue.init_journal(User.current)
      journal.details << JournalDetail.new(
        :property => 'attr',
        :prop_key => 'author_id',
        :old_value => old_author.id,
        :value => new_author.id)
      journal.save
    end
  end
end
