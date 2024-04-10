# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_events = current_user.events
    @joined_events = current_user.joined_events
    @events = Event.all.order(created_at: :desc)
  end
end
