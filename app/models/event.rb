# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :joined_users,
                          class_name: 'User',
                          association_foreign_key: 'user_id'

  validates :name, presence: true
  validates :total_slots, length: { in: 1..1000 }, presence: true

  def booked_slots
    total_slots - available_slots
  end
end
