module RedmineChangeauthor::Infectors::IssuesHelper

  def self.included(base)
    base.class_eval do
      def show_detail(detail, no_html=false, options={})
        if detail.property == 'attr' && detail.prop_key == 'author_id'
          field = detail.prop_key.to_s.gsub(/\_id$/, '')
          detail[:value] = find_name_by_reflection(field, detail.value) || detail.value
          detail[:old_value] = find_name_by_reflection(field, detail.old_value) || detail.old_value
        end
        super(detail, no_html, options)
      end
    end
  end

end