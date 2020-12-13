class Appointment < ApplicationRecord
  LENGTH = 30.minutes
  belongs_to :user

  validate :ensure_one_per_day, :ensure_on_half_hours

  # Can dynamically determine the end at so no need to store
  def end_at
    start_at + LENGTH
  end

  private

  def ensure_one_per_day
    date_range = (start_at.beginning_of_day...start_at.end_of_day)

    # Find appointments this user has today, excluding the current object
    todays_appointments = user.appointments.where(start_at: date_range).where.not(id: self.id)

    if todays_appointments.present?
      errors.add(:base, "User #{user_id} already has an appointment on #{start_at.to_date}")
    end
  end

  def ensure_on_half_hours
    beginning_of_hour = start_at.beginning_of_hour
    half_hour = beginning_of_hour + 30.minutes

    if ![beginning_of_hour, half_hour].include?(start_at)
      errors.add(:base, "Appointments must be exactly on the half hours")
    end
  end
end
