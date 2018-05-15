class PostSub < ApplicationRecord

  validates :post_id, :sub_id, presence: true

  # it has a sub that it is displayed on
  belongs_to :sub

  # it has a post it refers to
  belongs_to :post


end
