class CardsController < ApplicationController
  before_action :set_card, only: %i[show update bookmark attempt]

  def show
    @mode = params[:mode]
    @next_card = @card.lesson.next_card(@mode, @card)
  end

  def attempt
    @card.user_answer = card_params[:user_answer]

    if @card.save
      next_card = @card.lesson.next_card("test", @card, true)

      redirect_to next_card.nil? ? @card.lesson : card_path("test", next_card)
    else
      render :show, status: :unprocessable_entity
    end
  end

  def update; end

  def bookmark
    @card.bookmarked = !@card.bookmarked
    @card.save
    redirect_to card_path(params[:mode], @card)
  end

  private

  def set_card
    @card = Card.find(params[:id])
    template_name = @card.card_template.name.downcase.gsub(' ', '_')
    @template_path = "cards/templates/#{template_name}"
  end

  def card_params
    params.require(:card).permit(:user_answer)
  end
end
