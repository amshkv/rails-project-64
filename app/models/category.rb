# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :posts, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
end
