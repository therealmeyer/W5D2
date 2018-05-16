class Sub < ApplicationRecord
  validates :user_id, :title, :description, presence: true

  belongs_to :moderator,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  has_many :posts,
  dependent: :destroy

  has_many :references,
  foreign_key: :sub_id,
  class_name: :PostSub

  has_many :crossposts,
  through: :references,
  source: :post

end
