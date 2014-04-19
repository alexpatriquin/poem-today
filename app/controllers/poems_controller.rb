class PoemsController < ApplicationController
  def show
    @poem = Poem.find(params[:id])
  end
end
