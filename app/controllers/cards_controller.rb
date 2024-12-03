class CardsController < ApplicationController
  before_action :set_card, only: %i[show update]

  def show
  end

  def update
    @card.update(card_params)

    if @card.save
      @card.lesson.verify_complete
      next_card = @card.lesson.next_card(@card)

      redirect_to next_card.nil? ? @card.lesson : next_card
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_card
    @card = Card.find(params[:id])
    template_name = @card.template.name.downcase.gsub(' ', '_')
    @template_path = "cards/templates/#{template_name}"
  end

  def card_params
    params.require(:card).permit(:user_answer)
  end
end
