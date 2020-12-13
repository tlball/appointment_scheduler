require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:user) { create(:user) }
  describe '#ensure_one_per_day' do
    context 'User has no Appointments' do
      it 'saves the Appointment for the User' do
        expect(user.appointments).to be_blank
        appointment = Appointment.new(start_at: Time.current.beginning_of_hour, user: user)

        expect(appointment).to be_valid appointment.save!
        expect(user.appointments.count).to eq(1)
      end

      it 'saves Appointment for User if Appointments exist for other Users' do
        other_user = create(:user)
        other_appointment = Appointment.create(start_at: Time.current.beginning_of_hour, user: other_user)
        expect(other_user.appointments.count).to eq(1)

        appointment = Appointment.new(start_at: other_appointment.start_at, user: user)

        expect(appointment).to be_valid
        appointment.save!
        expect(user.appointments.count).to eq(1)
      end
    end

    context 'for User with existing Appointment' do
      let!(:existing_appointment) { Appointment.create!(start_at: Time.current.beginning_of_hour, user: user) }

      it 'saves Appointment for User if no others exist that day' do
        expect(user.appointments.count).to eq(1)

        other_appointment = Appointment.new(start_at: 1.day.from_now.beginning_of_hour, user: user)

        expect(other_appointment).to be_valid
        other_appointment.save!
        expect(user.appointments.count).to eq(2)
      end

      it 'saves Appointment for User at end of the day before the existing Appointment' do
        expect(user.appointments.count).to eq(1)
        start_at = (existing_appointment.start_at - 1.day).end_of_day.beginning_of_hour

        other_appointment = Appointment.new(start_at: start_at, user: user)

        expect(other_appointment).to be_valid
        other_appointment.save!
        expect(user.appointments.count).to eq(2)
      end

      it 'saves Appointment for User at beginning of the day after the existing Appointment' do
        expect(user.appointments.count).to eq(1)
        start_at = (existing_appointment.start_at + 1.day).beginning_of_day

        other_appointment = Appointment.new(start_at: start_at, user: user)

        expect(other_appointment).to be_valid
        other_appointment.save!
        expect(user.appointments.count).to eq(2)
      end

      it 'does not save an Appointment at end of day of existing Appointment' do
        expect(user.appointments.count).to eq(1)
        start_at = existing_appointment.start_at.end_of_day.beginning_of_hour

        eod_appointment = Appointment.new(start_at: start_at, user: user)
        expect(eod_appointment).not_to be_valid
        expect(eod_appointment.save).to be false
        expect(user.appointments.count).to eq(1)

        expect(eod_appointment.errors.full_messages)
          .to match_array(["User #{user.id} already has an appointment on #{eod_appointment.start_at.to_date}"])
      end

      it 'does not save an Appointment at beginning of day of existing Appointment' do
        expect(user.appointments.count).to eq(1)
        start_at = existing_appointment.start_at.beginning_of_day

        bod_appointment = Appointment.new(start_at: start_at, user: user)
        expect(bod_appointment).not_to be_valid
        expect(bod_appointment.save).to be false
        expect(user.appointments.count).to eq(1)

        expect(bod_appointment.errors.full_messages)
          .to match_array(["User #{user.id} already has an appointment on #{bod_appointment.start_at.to_date}"])
      end
    end
  end

  describe '#ensure_on_the_half_hours' do
    it 'saves if Appointment is at the top of the hour' do
      appointment = Appointment.new(start_at: Time.current.beginning_of_hour, user: user)

      expect(appointment).to be_valid
      appointment.save!
      expect(user.appointments.count).to eq(1)
    end

    it 'saves if Appointment is at the half hour' do
      start_at = Time.current.beginning_of_hour + 30.minutes
      appointment = Appointment.new(start_at: start_at, user: user)

      expect(appointment).to be_valid
      appointment.save!
      expect(user.appointments.count).to eq(1)
    end

    it 'does not save if Appointment is not on the hour' do
      start_at = Time.current.beginning_of_hour + 1.second
      appointment = Appointment.new(start_at: start_at, user: user)

      expect(appointment).not_to be_valid
      expect(appointment.save).to be false
      expect(user.appointments.count).to eq(0)
    end

    it 'does not save if Appointment is not on the half hour' do
      start_at = Time.current.beginning_of_hour + 30.minutes + 1.second
      appointment = Appointment.new(start_at: start_at, user: user)

      expect(appointment).not_to be_valid
      expect(appointment.save).to be false
      expect(user.appointments.count).to eq(0)
    end
  end
end
