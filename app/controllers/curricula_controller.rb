class CurriculaController < ApplicationController

  def index
    @curricula = Curriculum.all
  end

  def new
    @curriculum = Curriculum.new
  end

  def create
    @curriculum = Curriculum.new(curriculum_params)
    @curriculum.user = current_user

    if @curriculum.save
      redirect_to curricula_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def curriculum_params
    params.require(:curriculum).permit(:title, :purpose, :start_date, :end_date, :context, :language_id)
  end
end
