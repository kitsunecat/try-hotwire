class TodosController < ApplicationController
  before_action :set_todo, only: %i[show edit update destroy]

  # GET /todos
  def index
    @search = Todo.ransack(params[:q])
    @todos = @search.result.page(params[:page])
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1
  def show; end

  # GET /todos/1/edit
  def edit; end

  # POST /todos
  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      flash.now.notice = 'Todo was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      flash.now.notice = 'Todo was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
    flash.now.notice = 'Todo was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo
    @todo = Todo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def todo_params
    params.require(:todo).permit(:title, :content)
  end
end
