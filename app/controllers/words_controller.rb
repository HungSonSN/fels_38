class WordsController < ApplicationController
  before_action :logged_in_user
  before_action :get_category, only: [:new, :create]

  def index
    if params[:id].blank?
      @words = Word.all
    else
      @category = Category.find params[:id]
      @words = @category.words
    end
    @words = @words.paginate page: params[:page]
    @words_part1 = @words.slice(0, 15)
    if @words.length > 15
      @words_part2 = @words.slice(15, 15)
    else
      @words_part2 = []
    end  
  end

  def new
    @word = @category.words.build
    4.times {@word.answers.build}
  end

  def create
    @word = @category.words.new word_params
    if @word.save
      flash[:success]= "Add word success"
      redirect_to controller: :words, action: :index, id: @word.category
    else
      render 'new'
    end  
  end  

  def edit
    @word = Word.find params[:id]
  end  

  def update
    @word = Word.find params[:id]
    if @word.update_attributes word_params
      flash[:success] = "Update word success"
      redirect_to controller: :words, action: :index, id: @word.category
    else 
      render 'edit'
    end  
  end

  def destroy
    Word.find(params[:id]).destroy
    flash[:success] = "Delete success"
    redirect_to controller: :words, action: :index, id: @word.category
  end  

  private
  def word_params
    params.require(:word).permit :content, :meaning,
      answers_attributes: [:id, :content, :_destroy, :correct]
  end
    
  def get_category
    @category = Category.find params[:category_id]  
  end  
end
