# frozen_string_literal: true

class EventUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_event
  before_action :set_defaults

  def create
    updated_event = EventsUsers::JoinEvent.new(@event, @user).call
    flash_message = { notice: "You have joined #{@event.name}" }
    flash_message = { alert: updated_event.errors.full_messages.join(',') } if updated_event.errors.present?

    respond_to do |format|
      format.html do
        redirect_to event_path(@event), flash_message
      end
    end
  end

  def destroy
    EventsUsers::LeaveEvent.new(@event, @user).call
    flash_message = "You have left #{@event.name}"
    flash_message = updated_event.errors.full_messages.join(',') if updated_event.errors.present?

    respond_to do |format|
      format.html do
        redirect_to event_path(@event), flash_message
      end
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id]) || current_user
  end

  def set_event
    @event = Event.find_by(id: params[:event_id])
  end

  def set_defaults
    @user_events = current_user.events
    @joined_events = current_user.joined_events
    @events = Event.all
  end
end
