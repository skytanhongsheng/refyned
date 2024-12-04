class CardsController < ApplicationController
  before_action :set_card, only: %i[show update bookmark attempt]

  def show
  end

  def attempt
    user_answer = card_params[:user_answer]

    @card.correct = @card.model_answer == user_answer

    if @card.save
      @card.lesson.verify_complete
      next_card = @card.lesson.next_card(@card)

      redirect_to next_card.nil? ? @card.lesson : next_card
    else
      render :show, status: :unprocessable_entity
    end
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

  def bookmark
    @card.bookmarked = !@card.bookmarked
    @card.save
    redirect_to card_path(@card)
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
