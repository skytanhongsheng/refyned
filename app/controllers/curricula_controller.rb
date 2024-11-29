class CurriculaController < ApplicationController
  before_action :set_curriculum, only: %i[show]
  def show
  end

  private

  def set_curriculum
    @curriculum = Curriculum.find(params[:id])
  end

  def curriculum_params
    params.require(:curricula).permit(:title, :purpose, :context, :start_date, :end_date)
  end
end
