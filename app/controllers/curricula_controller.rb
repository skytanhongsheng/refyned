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
    #   title: 'Business trip to China',
    #   purpose: 'I am going on a business trip to Shanghai',
    #   context: 'I want to use Mandarin to speak with Chinese business clients',
    #   start_date: "Mon, 9 Dec 2024",
    #   end_date: "Mon, 16 Dec 2024",
    #   language: Language.find_by(name: "Mandarin"),
    #   lesson_hours: 1,
    #   card_templates: CardTemplate.all
    # )

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
