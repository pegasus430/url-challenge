# frozen_string_literal: true

class Url < ApplicationRecord
  # scope :latest, -> {}
  validates :original_url, presence: true
  validates :short_url, presence: true
  validates :short_url, uniqueness: true
  validates :short_url, length: { minimum: 5 }
  validates :short_url, format: { with: /[A-Z]+/, message: "only allows uppercase letters" }
  validates :clicks_count, numericality: { only_integer: true }
end
