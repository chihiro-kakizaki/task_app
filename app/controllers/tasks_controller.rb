class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)

  def index
    @tasks = Task.all.page(params[:page]).per(4).create_desc
    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
        if (title && status).present?
          @tasks = @tasks.page(params[:page]).per(4).search_title(title).search_status(status)
        elsif title.present?
          @tasks = @tasks.page(params[:page]).per(4).search_title(title)
        elsif status.present?
          @tasks = @tasks.page(params[:page]).per(4).search_status(status)
        end
    elsif params[:sort_expired]
      @tasks = Task.all.page(params[:page]).per(4).expire_desc
    elsif params[:sort_priority]
      @tasks = Task.all.page(params[:page]).per(4).priority_asc
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました"
  end

  private
  
  def task_params
    params.require(:task).permit(
      :title, 
      :content,
      :expired_at,
      :status,
      :priority
      )
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
