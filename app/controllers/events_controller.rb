# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, except: %i[index new create]

  def index
    @events = current_user.events
  end

  def new
    @event = current_user.events.new
  end

  def create
    @event = Events::CreateEvent.new(event_params, current_user).call
    flash[:alert] = @event.errors.full_messages.join(', ') if @event.errors.present?

    if @event.persisted?
      redirect_to events_path, notice: 'Successfully created an event'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @event = Events::UpdateEvent.new(event_params).call
    flash[:alert] = @event.errors.full_messages.join(', ') if @event.errors.present?

    if @event.errors.blank?
      redirect_to events_path, notice: 'Successfully created an event'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Events::DeleteEvent.new(@event).call

    redirect_to events_path, alert: @event.errors.full_messages.join(', ')
  end

  def show
    @joined_users = @event.joined_users
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :total_slots, :lat, :long)
  end

  def set_event
    @event = Event.find_by(id: params[:id])
  end
end
