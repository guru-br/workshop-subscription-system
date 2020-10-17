# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Workshop, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:short_description) }
    it { should validate_presence_of(:full_description) }
    it { should validate_presence_of(:attendees) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:workshop_date) }
    it { should validate_presence_of(:start_time) }
  end
end
