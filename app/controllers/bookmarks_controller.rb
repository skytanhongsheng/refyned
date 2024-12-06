class BookmarksController < ApplicationController
  def index
    @curricula = Curriculum
                 .where(user: current_user)
                 .reject { |curriculum| curriculum.bookmarks.empty? }
  end
end
