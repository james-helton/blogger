class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  belongs_to :author
  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>' }
  validates_attachment_content_type :image,
    :content_type => ['image/jpg', 'image/jpeg', 'image/png']

  def tag_list
    tags.join(', ')
  end

  def tag_list=(list_of_tags)
    uniq_tags = list_of_tags.split(',').collect { |t| t.strip.downcase }
    self.tags = uniq_tags.collect { |t| Tag.find_or_create_by(name: t) }
  end
end
