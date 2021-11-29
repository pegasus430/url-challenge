# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Click, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      click = Click.new(platform: "Windows NT",
                        browser: "Chrome",
                        created_at: DateTime.now,
                        updated_at: DateTime.now,
                        url_id: 1
                        )
      expect(click).to be_valid
    end

    it 'validates browser is not null' do
      click = Click.new(platform: "Windows NT",
                        browser: nil,
                        created_at: DateTime.now,
                        updated_at: DateTime.now,
                        url_id: 1
                        )
      expect(click).to_not be_valid
    end

    it 'validates platform is not null' do
      click = Click.new(platform: nil,
                        browser: "Chrome",
                        created_at: DateTime.now,
                        updated_at: DateTime.now,
                        url_id: 1
                        )
      expect(click).to_not be_valid
    end

    it 'is not valid with the non-numeric URL ID' do
      click = Click.new(platform: "Windows NT",
                        browser: "Chrome",
                        created_at: DateTime.now,
                        updated_at: DateTime.now,
                        url_id: "URL ID"
                        )
      expect(click).to_not be_valid
    end
  end
end
