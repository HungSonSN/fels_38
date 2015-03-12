class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy

  validates :name, presence: true, uniqueness:
          {case_sensitive: false, message: "of category has already exist!"}
          
  def learned_words user
    user.lessons.select{|lesson| lesson.category == self}.
      map(&:results).flatten.map(&:word).uniq
  end

  def words_not_learned_by user
    Word.all.select{|lesson| lesson.category == self}.select do |word|
      !user.learned_words.include? word
    end
  end
end
