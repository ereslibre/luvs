class ProjectsController < ApplicationController
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @projects }
    end
  end

  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @project }
    end
  end

  def luv
    @project = Project.find(params[:id])

    if not user_signed_in?
      flash[:alert] = "You need to login in order to luv #{@project.name}"
      redirect_to :action => 'show'
      return
    end

    Luv.create(:project_id => @project, :user_id => current_user)
    flash[:notice] = "You are now luvin' project #{@project.name}"
    redirect_to :action => 'show'
  end
end
