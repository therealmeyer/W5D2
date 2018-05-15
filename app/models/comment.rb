class Comment < ApplicationRecord

  validates :content, :user_id, :post_id, presence: true

  attr_accessor :sub_id

  has_many :comments,
  primary_key: :id,
  foreign_key: :comment_id,
  class_name: :Comment

  belongs_to :post

  has_one :sub,
  through: :post,
  source: :sub 

  belongs_to :author,
  foreign_key: :user_id,
  class_name: :User

  belongs_to :parent_comment,
  foreign_key: :comment_id,
  class_name: :Comment,
  optional: true


end
