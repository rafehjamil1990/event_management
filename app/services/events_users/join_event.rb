# frozen_string_literal: true

module EventsUsers
  class JoinEvent
    def initialize(event, user)
      @event = event
      @user = user
    end

    def call
      ActiveRecord::Base.transaction do
        @event.lock!
        return unless @event.available_slots.positive?

        @user.joined_events << @event
        @event.available_slots = @event.available_slots - 1
        @event.save
      end
    end
  end
end
