# frozen_string_literal: true

json.id @article.id
json.title @article.title
json.description @article.description
json.author @article.user.username