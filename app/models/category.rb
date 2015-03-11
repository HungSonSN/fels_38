class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy

  validates :name, presence: true, uniqueness:
          {case_sensitive: false, message: "of category has already exist!"}
  def learned_word?(user)
    learned_word_ids = "SELECT word_id FROM learns WHERE user_id = :user_id"
    Word.where("id IN (#{learned_word_ids}) AND category_id = :category_id", 
                                        user_id: user.id, category_id: id)
  end
end
