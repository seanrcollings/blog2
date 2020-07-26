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
  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, presence: true, length: { minimum: 5 }
  has_rich_text :text
end
