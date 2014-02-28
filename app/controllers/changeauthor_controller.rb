class ChangeauthorController < ApplicationController
  unloadable
  menu_item :issues
  default_search_scope :issues

  before_filter :find_issue
  before_filter :authorize

  def index
    @users = @project.users.order(:firstname)
    @issue_user = User.where(:id => @issue["author_id"]).first
  end

  def edit
    old_author = @issue.author
    if @issue.update_attribute(:author_id, params[:authorid])
      flash[:notice] = l(:notice_successful_update)
      call_hook(:controller_redmine_changeauthor_edit_after_save, { :old_author => old_author.name, :new_author => @issue.author.name, :issue => @issue })

      redirect_to :controller => "issues", :action => "show", :id => params[:id]
    else
      redirect_to :controller => "changeauthor", :action => "edit", :id => params[:id]
    end
  end

  private

  def find_and_destroy_relation(id)
    H4prelation.where(:project_identifier => id).delete_all
  end

end
