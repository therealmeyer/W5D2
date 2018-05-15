class Post < ApplicationRecord

  validates :title, :user_id, :sub_id, presence: true

  belongs_to :author,
  foreign_key: :user_id,
  class_name: :User

  belongs_to :sub

  has_many :references,
  foreign_key: :post_id,
  class_name: :PostSub

  has_many :comments 

end
