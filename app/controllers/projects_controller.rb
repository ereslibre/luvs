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

  def new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def luv
    @project = Project.find(params[:id])

    if user_signed_in?
      if Luv.where(:project_id => @project.id, :user_id => current_user.id).exists?
        flash[:alert] = "You are already luvin' project #{@project.name}"
      else
        Luv.create(:project_id => @project.id, :user_id => current_user.id)
        flash[:notice] = "You are now luvin' project #{@project.name}"
      end
    else
      flash[:alert] = "You need to login in order to luv #{@project.name}"
    end
    redirect_to :action => 'show'
  end

  def unluv
    @project = Project.find(params[:id])

    if user_signed_in?
      if not Luv.where(:project_id => @project.id, :user_id => current_user.id).exists?
        flash[:alert] = "You are not yet luvin' project #{@project.name}"
      else
        Luv.where(:project_id => @project.id, :user_id => current_user.id).first.delete
        flash[:notice] = "You are not luvin' project #{@project.name} anymore"
      end
    else
      flash[:alert] = "You need to login in order to unluv #{@project.name}"
    end
    redirect_to :action => 'show'
  end

  def luvin?(project)
    Luv.where(:project_id => project.id, :user_id => current_user.id).exists?
  end
  helper_method :luvin?

end
