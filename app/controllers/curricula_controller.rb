class CurriculaController < ApplicationController
  before_action :set_curriculum, only: %i[show]

  def show
  end

  def index
    @curricula = Curriculum.all
  end

  def new
    # === Use for testing ===
    # @curriculum = Curriculum.new(
    #   title: 'Trip 2024',
    #   purpose: 'holiday to china',
    #   context: 'I want to be able to handle basic conversations',
    #   start_date: "Fri, 6 Dec 2024",
    #   end_date: "Fri, 10 Dec 2024",
    #   language: Language.find(6),
    #   lesson_hours: 1
    # )

    # @curriculum.card_templates << CardTemplate.all

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
    params.require(:curriculum).permit(:title, :purpose, :context, :start_date, :end_date, :language_id, :lesson_hours,
                                       card_template_ids: [])
  end
end
