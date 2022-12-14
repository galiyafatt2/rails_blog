# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
    end
  end
end
