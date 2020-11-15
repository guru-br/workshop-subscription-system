# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe 'associations' do
    it { should belong_to(:workshop) }
    it { should belong_to(:attendee) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end
end
