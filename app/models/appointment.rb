class Appointment < ApplicationRecord
  belongs_to :user

  validate :ensure_one_per_day

  private

  def ensure_one_per_day
    date_range = (start_at.beginning_of_day...start_at.end_of_day)

    # Find appointments this user has today, excluding the current object
    todays_appointments = user.appointments.where(start_at: date_range).where.not(id: self.id)

    if todays_appointments.present?
      errors.add(:base, "User #{user_id} already has an appointment on #{start_at.to_date}")
    end
  end
end
