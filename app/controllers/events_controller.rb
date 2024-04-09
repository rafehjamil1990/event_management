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

    if @event.persisted?
      redirect_to events_path
    else
      render :new
    end
  end

  def edit; end

  def update
    @event = Events::UpdateEvent.new(event_params).call

    if @event.errors.blank?
      redirect_to events_path
    else
      render :edit
    end
  end

  def destroy
    @event = Events::DeleteEvent.new(@event)

    redirect_to events_path
  end

  def show
    @joined_users = @event.joined_users
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :total_slots, :lat, :long)
  end

  def set_event
    @event = current_user.events.find_by(id: params[:id])
  end
end
