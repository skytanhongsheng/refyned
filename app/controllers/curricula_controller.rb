class CurriculaController < ApplicationController
  before_action :set_curriculum, only: %i[show]

  def show
  end

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

  def set_curriculum
    @curriculum = Curriculum.find(params[:id])
  end

  def curriculum_params
    params.require(:curriculum).permit(:title, :purpose, :context, :start_date, :end_date, :language_id,
                                       card_template_ids: [])
  end
end
