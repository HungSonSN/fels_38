class Word < ActiveRecord::Base
  belongs_to :category
  has_many  :answers, dependent: :destroy
  has_many  :learns, dependent: :destroy

  validates :content, presence: true, uniqueness: 
                {case_sensitive: false, message: "of word has already exist!"}
  validates :meaning, presence: true
  validates :category, presence: true

  accepts_nested_attributes_for :answers, allow_destroy: true
  validate :has_correct_answer
  private
  def has_correct_answer
    unless answers.any? {|answer| answer.correct?}
      errors.add(:base, "Word must have one correct answer!")
    end
  end
end