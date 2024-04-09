# frozen_string_literal: true

class EventUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_event
  before_action :set_defaults

  def create
    EventsUsers::JoinEvent.new(@event, @user).call

    respond_to do |format|
      format.html do
        redirect_to event_path(@event)
      end
    end
  end

  def destroy
    EventsUsers::LeaveEvent.new(@event, @user).call

    respond_to do |format|
      format.html do
        redirect_to event_path(@event)
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
