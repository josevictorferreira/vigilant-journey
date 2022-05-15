class SavingsController < ApplicationController
  before_action :set_saving, only: %i[show update destroy], except: %i[current_month]

  def index
    @savings = Saving.all

    render json: @savings
  end

  def show
    render json: @saving
  end

  def create
    @saving = Saving.new(saving_params)

    if @saving.save
      render json: @saving, status: :created, location: @saving
    else
      render json: @saving.errors, status: :unprocessable_entity
    end
  end

  def update
    if @saving.update(saving_params)
      render json: @saving
    else
      render json: @saving.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @saving.destroy
  end

  def current_month
    current_time = Time.current
    start = current_time.beginning_of_month
    final = current_time.end_of_month

    total = Saving.where(date: start..final).sum(:value)

    render json: { total: }, status: :ok
  end

  private

  def set_saving
    @saving = Saving.find(params[:id])
  end

  def saving_params
    params.require(:saving).permit(:value, :date)
  end
end
