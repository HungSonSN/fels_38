class LessonsController < ApplicationController
  def show
    @category = Category.find params[:id]
    @lesson = @category.lessons.sample
    if @lesson.nil?
      flash[:danger] = "System don't have lesson in category.
      Please chose different category"
      redirect_to categories_path
    else
      @words = @category.words.sample 20
    end
  end

  def index
    if params[:result]
      @question_list = params[:result]
      answer_ids = @question_list.values
      @answers = Answer.show_result answer_ids
    end
  end
end