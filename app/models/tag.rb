class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings
  validate :valid_hex_color
  validates :name, presence: true, uniqueness: true
  before_save :lower_name, :pick_color

  HEX_COLORS = [
    "#d654c3", "#3cb371", "#9ca7d6", "#31a6b8", "#696969", "#bada55", "#666666",
    "#7fe5f0", "#ff0000", "#ff80ed", "#407294", "#cbcba9", "#420420", "#8a2be2",
    "#dcedc1", "#000000", "#f7347a", "#576675", "#ffc0cb", "#ffe4e1", "#696966",
    "#008080", "#ffd700", "#e6e6fa", "#ffa500", "#ff7373", "#40e0d0", "#00ffff",
    "#0000ff", "#b0e0e6", "#c6e2ff", "#003366", "#133337", "#065535", "#c0c0c0",
    "#fa8072", "#7fffd4", "#800000", "#ffb6c1", "#800080", "#5ac18e", "#dddddd",
    "#00ff00", "#cccccc", "#ffc3a0", "#f08080", "#c39797", "#20b2aa", "#ff4040",
    "#333333", "#66cdaa", "#ff6666", "#4ca3dd", "#ffdab9", "#ff7f50", "#468499",
    "#ff00ff", "#f6546a", "#afeeee", "#c0d6e4", "#008000", "#00ced1", "#660066",
    "#0e2f44", "#990000", "#cbbeb5", "#088da5", "#101010", "#8b0000", "#daa520",
    "#b6fcd5", "#b4eeb4", "#808080", "#6897bb", "#66cccc", "#794044", "#000080",
    "#81d8d0",
  ]

  def to_param
    name
  end

  def lower_name
    self.name = self.name.downcase
  end

  def pick_color
    if self.color == nil or self.color == ""
      self.color = Tag::HEX_COLORS.sample
    end
  end

  private

  def valid_hex_color
    return if color == nil or color.length == 0

    hex_regex = /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i
    result = color.scan(hex_regex)
    unless result.length == 1
      errors.add(:color, "must be a valid hex code")
    end
  end
end
