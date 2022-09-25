# frozen_string_literal: true

class Article < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }

  scope :title_or_description_like, ->(params) {
    where("title LIKE ?", "%#{sanitize_sql_like(params)}%").or(where("description LIKE ?", "%#{sanitize_sql_like(params)}%"))
  }
end
