class Post < ActiveRecord::Base

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :user, presence: true
  validates :title, presence: true
  validates :content, presence: true

end
