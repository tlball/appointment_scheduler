class AppointmentsController < ApplicationController
  respond_to :json

  def create
    @appointment = Appointment.create!(user:user, start_at: appointment_params[:start_at])
    render json: @appointment
  end

  def index
    @appointments = user.appointments
    render json: @appointments
  end

  private

  def appointment_params
    params.require(:appointment)
      .permit(:start_at)
  end

  def user
    @user ||= User.find(params.require(:user_id))
  end
end
