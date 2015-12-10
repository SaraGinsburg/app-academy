class Api::StepsController < ApplicationController
  def index
    render json: Todo.find(params[:todo_id]).steps
  end

  def create
    render json: Step.create!(step_params)
  end

  def update
    render json: current_step.update!(step_params)
  end

  def show
    render json: current_step
  end

  def destroy
    temp = current_step
    current_step.destroy!
    render json: temp
  end

  private

  def step_params
    new_params = params.require(:step).permit(:body, :done)
    new_params[:todo_id] = params[:todo_id]
    new_params
  end

  def current_step
    Step.find(params[:id])
  end
end
