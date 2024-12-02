class CardsController < ApplicationController
  before_action :set_card, only: %i[show]

  def show

  end

  private

  def set_card
    @card = Card.find[params[:id]]
  end
end
