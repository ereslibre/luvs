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
end
