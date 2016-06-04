class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def tag_list
    tags.join(', ')
  end

  def tag_list=(list_of_tags)
    uniq_tags = list_of_tags.split(',').collect { |t| t.strip.downcase }
    self.tags = uniq_tags.collect { |t| Tag.find_or_create_by(name: t) }
  end
end
