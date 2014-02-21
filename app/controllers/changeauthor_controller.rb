class ChangeauthorController < ApplicationController
  unloadable
  layout 'admin'

  def index
    @issue = Issue.where(:id => params[:issue_id]).first
    @project = Project.where(:id => @issue.project_id).first
    @users = @project.members.order(:firstname)
    @issue_user = User.where(:id => @issue["author_id"]).first
  end

  def edit
    @issue = Issue.where(:id => params[:issue_id]).first
    old_author = @issue.author
    if @issue.update_attribute(:author_id, params[:authorid])
      flash[:notice] = l(:notice_successful_update)
      call_hook(:controller_redmine_changeauthor_edit_after_save, { :old_author => old_author.name, :new_author => @issue.author.name, :issue => @issue })

      redirect_to :controller => "issues", :action => "show", :id => params[:issue_id]
    else
      redirect_to :controller => "changeauthor", :action => "edit", :id => params[:issue_id]
    end
  end

  private

  def find_and_destroy_relation(id)
    H4prelation.where(:project_identifier => id).delete_all
  end

end
