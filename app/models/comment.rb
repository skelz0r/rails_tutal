class Comment < ActiveRecord::Base

  belongs_to :post
  belongs_to :user

  validates :user, presence: true
  validates :post, presence: true
  validates :content, presence: true

end
