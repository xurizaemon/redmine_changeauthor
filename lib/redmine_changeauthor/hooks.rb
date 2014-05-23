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

  module IssuesHelperPatch
    def self.included(base)
      base.class_eval do
        alias orig_show_detail_by_changeauthor show_detail
        def show_detail(detail, no_html=false, options={})
          if detail.property == 'attr' && detail.prop_key == 'author_id'
            field = detail.prop_key.to_s.gsub(/\_id$/, "")
            detail[:value] = find_name_by_reflection(field, detail.value) || detail.value
            detail[:old_value] = find_name_by_reflection(field, detail.old_value) || detail.old_value
          end
          orig_show_detail_by_changeauthor(detail, no_html, options)
        end
      end
    end
  end

  IssuesHelper.send(:include, IssuesHelperPatch) unless IssuesHelper.included_modules.include? IssuesHelperPatch
end
