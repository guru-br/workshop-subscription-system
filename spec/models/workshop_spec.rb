# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Workshop, type: :model do
  describe 'associations' do
    it { should have_many(:enrollments) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:short_description) }
    it { should validate_presence_of(:full_description) }
    it { should validate_presence_of(:attendees) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:workshop_date) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:status) }
  end

  describe '#waiting_list_enroll' do
    context 'When the workshop has reached full enrollments' do
      it 'enrolls the attendee on the waiting list' do
        workshop = create(:workshop, attendees: 1)
        attendee = create(:attendee)
        other_attendee = create(:attendee)
        workshop.enrollments.create(attendee: attendee)

        result = workshop.waiting_list_enroll(other_attendee)

        expect(result).to be_kind_of(Enrollment)
        expect(Enrollment.count).to eq 2
        expect(Enrollment.first.attendee).to eq(attendee)
        expect(Enrollment.first.status).to eq('enrolled')
        expect(Enrollment.last.attendee).to eq(other_attendee)
        expect(Enrollment.last.status).to eq('waiting_list')
      end
    end

    context 'When the workshop has not reached full enrollments' do
      it 'does not enroll the attendee on the waiting list' do
        workshop = create(:workshop, attendees: 1)
        attendee = create(:attendee)

        result = workshop.waiting_list_enroll(attendee)

        expect(result).to be(nil)
        expect(Enrollment.count).to eq(0)
      end
    end
  end

  describe '#full?' do
    context 'When the workshop has reached full enrollments' do
      it 'returns true' do
        workshop = create(:workshop, attendees: 2)
        attendee = create(:attendee)
        other_attendee = create(:attendee)
        workshop.enrollments.create(attendee: attendee)
        workshop.enrollments.create(attendee: other_attendee)

        expect(workshop.full?).to eq(true)
      end
    end

    context 'When the workshop has not reached full enrollments' do
      it 'returns false' do
        workshop = create(:workshop, attendees: 2)
        attendee = create(:attendee)
        workshop.enrollments.create(attendee: attendee)

        expect(workshop.full?).to eq(false)
      end
    end

    describe '#enrolled?' do
      context 'When the attendee is enrolled on this workshop' do
        it 'returns true' do
          workshop = create(:workshop, attendees: 2)
          attendee = create(:attendee)
          workshop.enrollments.create(attendee: attendee)

          expect(workshop.enrolled?(attendee)).to eq(true)
        end
      end

      context 'When the attendee is enrolled on this workshop waiting list' do
        it 'returns true' do
          workshop = create(:workshop, attendees: 2)
          attendee = create(:attendee)
          workshop.enrollments.create(attendee: attendee, status: :waiting_list)

          expect(workshop.enrolled?(attendee)).to eq(false)
        end
      end

      context 'When the attendee is not enrolled on this workshop' do
        it 'returns false' do
          workshop = create(:workshop, attendees: 2)
          attendee = create(:attendee)

          expect(workshop.enrolled?(attendee)).to eq(false)
        end
      end
    end
  end

  describe '#disenroll' do
    context 'When the attendee is enrolled on this workshop' do
      it 'returns the enrollment destroyed' do
        workshop = create(:workshop, attendees: 1, status: :active)
        attendee = create(:attendee)
        workshop.enrollments.create(attendee: attendee)
        enrollment = workshop.enrollments.last

        expect(workshop.disenroll(attendee)).to eq(enrollment)
      end
    end

    context 'When the attendee is enrolled on this workshop waiting list' do
      it 'returns nil' do
        workshop = create(:workshop, attendees: 0)
        attendee = create(:attendee)

        result = workshop.waiting_list_enroll(attendee)
        expect(result).to be_kind_of(Enrollment)

        expect(workshop.disenroll(attendee)).to eq(nil)
      end
    end

    context 'When the attendee is not enrolled on this workshop' do
      it 'returns nil' do
        workshop = create(:workshop, attendees: 1)
        attendee = create(:attendee)

        expect(workshop.disenroll(attendee)).to eq(nil)
      end
    end
  end
end
