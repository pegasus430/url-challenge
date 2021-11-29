# frozen_string_literal: true

class Click < ApplicationRecord
  belongs_to :url

  validates :browser, :platform, presence: true
  validates :url_id, numericality: { only_integer: true }
end
