class AnswersController < ApplicationController
  def index
    @answers = Answer.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
