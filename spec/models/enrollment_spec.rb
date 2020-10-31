# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:workshop) }
    it { should validate_presence_of(:attendee) }
    it { should validate_presence_of(:status) }
  end
end
