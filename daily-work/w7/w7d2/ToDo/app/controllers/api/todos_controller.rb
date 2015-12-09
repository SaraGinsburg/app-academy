class Api::TodosController < ApplicationController
  def index
    render json: Todo.all
  end

  def create
    render json: Todo.create!(todo_params)
  end

  def update
    render json: current_todo.update!(todo_params)
  end

  def show
    render json: current_todo
  end

  def destroy
    temp = current_todo
    current_todo.destroy!
    render json: temp
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :body, :done)
  end

  def current_todo
    Todo.find(params[:id])
  end

end
