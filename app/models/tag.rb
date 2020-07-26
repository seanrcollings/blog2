class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings
  validate :valid_hex_color
  validates :name, presence: true

  def to_param
    name
  end

  private

  def valid_hex_color
    hex_regex = /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i
    result = color.scan(hex_regex)
    unless result.length == 1
      errors.add(:color, "must be a valid hex hex code")
    end
  end
end
