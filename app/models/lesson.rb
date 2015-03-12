class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many   :results, dependent: :destroy

  accepts_nested_attributes_for :results, allow_destroy: true

  # validates :name, presence: true
  validates :user, presence: true
  validates :category, presence: true

  def count_correct_answer
    self.results.select{|result| 
      result.answer.correct? unless result.answer.nil?}.count
  end  
end