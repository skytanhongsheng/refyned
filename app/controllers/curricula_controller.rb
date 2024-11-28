class CurriculaController < ApplicationController
  def new
    @curriculum = Curriculum.new
  end

  def index
    @curriculums = Curriculum.all
  end

  def create
    @curriculum = Curriculum.new(curriculum_params)
    raise
    if @curriculum.save
      redirect_to curricula_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def curriculum_params
    params.require(:curriculum).permit(:title, :purpose, :start_date, :end_date, :context)
  end
end
