class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true

  validates :description, presence: true

  enum state: {
    open: 0,
    closed: 1
  }

  enum kind: {
    default: 0,
    question: 1,
    answer: 2
  }
end
