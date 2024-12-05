class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find(params[:id])
    @mode = params[:mode] || "learning"
  end

  def update
    @lesson = Lesson.find(params[:id])
    @lesson = update(lesson_params)
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
  end

  private

  def lesson_params
    params.require(:lesson).permit(:title, :description, :score, :progress)
  end
end
