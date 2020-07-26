# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           default(1), not null
#
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, length: { minimum: 5 }
  validates :text, presence: true
  has_rich_text :text

  def add_tags(tags)
    self.tags = []
    tags = tags.split(",").map { |tag| tag.strip }

    tags.each do |tag_name|
      tag = Tag.find_by(name: tag_name)
      if tag
        self.tags << tag
      else
        tag = Tag.new(name: tag_name)
        tag.save
        self.tags << tag
      end
    end
  end
end
