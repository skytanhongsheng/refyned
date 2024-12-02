class CardsController < ApplicationController
  before_action :set_card, only: %i[show]

  def show
    template_name = @card.template.name.downcase.gsub(' ', '_')
    @template_path = "cards/templates/#{template_name}"
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end
end
