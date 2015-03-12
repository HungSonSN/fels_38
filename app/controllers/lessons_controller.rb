class LessonsController < ApplicationController

  def index
    @category = Category.find params[:category_id]
    @lessons = @category.lessons_of current_user
    @lessons = @lessons.paginate page: params[:page]
  end

  def create
    @category = Category.find params[:category_id]
    @words = @category.words.sample 20
    @lesson = Lesson.new user: current_user, category: @category, name: params[:name]
    @words.shuffle.each do |word|
      @lesson.results.build word: word
    end
    if @lesson.save
      redirect_to category_lesson_path @category, @lesson
    else
      flash[:danger] = "Lesson has not been created"
      redirect_to root_url
    end
  end

  def show
    @lesson = Lesson.find params[:id]
  end  

  def update
    @lesson = Lesson.find params[:id]
    if @lesson.update_attributes lesson_params
      flash[:success] = "Finish lesson"
      redirect_to lesson_results_path lesson_id: @lesson.id
    else
      redirect_to categories_path
    end  
  end  

  private 
  def lesson_params
    params.require(:lesson).permit results_attributes: [:id, :answer_id]
  end  
end