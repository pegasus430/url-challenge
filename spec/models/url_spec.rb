# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  
  describe 'validations' do
    # it 'validates original URL is a valid URL' do
    #   skip 'add test'
    # end

    # it 'validates short URL is present' do
    #   skip 'add test'
    # end

    it 'is valid with valid attributes' do
      url = Url.new(original_url: "https://google.com",
                        short_url: "AADEV",
                        created_at: DateTime.now,
                        updated_at: DateTime.now,
                        id: 1
                        )
      expect(url).to be_valid
    end

    it 'is not valid without original URL' do
      url = Url.new(original_url: nil,
                        short_url: "AADEV",
                        created_at: DateTime.now,
                        updated_at: DateTime.now,
                        id: 1
                        )
      expect(url).to_not be_valid
    end

    it 'is not valid without short URL' do
      url = Url.new(original_url: "https://google.com",
                        short_url: nil,
                        created_at: DateTime.now,
                        updated_at: DateTime.now,
                        id: 1
                        )
      expect(url).to_not be_valid
    end

    it ': short URL length should be equal or more than 5' do
      url = Url.new(original_url: "https://google.com",
                        short_url: "AADE",
                        created_at: DateTime.now,
                        updated_at: DateTime.now,
                        id: 2
                        )
      expect(url).to_not be_valid
    end

    it ': short URL should only allow the uppercase letters' do
      url = Url.new(original_url: "https://google.com",
                        short_url: "diekd",
                        created_at: DateTime.now,
                        updated_at: DateTime.now,
                        id: 2
                        )
      expect(url).to_not be_valid
    end

    it 'is not valid with the non-numeric clicks count' do
      url = Url.new(original_url: "https://google.com",
                        short_url: "AADEV",
                        created_at: DateTime.now,
                        updated_at: DateTime.now,
                        clicks_count: 'click count',
                        id: 2
                        )
      expect(url).to_not be_valid
    end

  end
end
