class WordsController < ApplicationController
  before_action :logged_in_user
  before_action :get_category, only: [:new, :create]

  def index
    learned = params[:learned]
    @words = if params[:category_id].blank?
      if learned == '1'
        current_user.learned_words
      elsif learned == '0'
        current_user.not_learned_words
      else
        Word.all
      end                
    else
      @category = Category.find params[:category_id]
      if learned == '1'
        @category.learned_words(current_user)
      elsif learned == '0'
        @category.words_not_learned_by(current_user)
      else
        @category.words
      end
    end
    @words = @words.paginate page: params[:page]

  end

  def new
    @word = @category.words.build
    4.times {@word.answers.build}
  end

  def create
    @word = @category.words.new word_params
    if @word.save
      flash[:success]= "Add word success"
      redirect_to words_path category_id: @category.id
    else
      render 'new'
    end  
  end  

  def edit
    @word = Word.find params[:id]
    @category = @word.category
  end  

  def update
    @word = Word.find params[:id]
    if @word.update_attributes word_params
      flash[:success] = "Update word success"
      redirect_to words_path category_id: @word.category.id
    else 
      render 'edit'
    end  
  end

  def destroy
    @word = Word.find params[:id]
    @word.destroy
    flash[:success] = "Delete success"
    redirect_to words_path category_id: @word.category.id
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
