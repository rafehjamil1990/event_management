# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_one_attached :avatar do |attachable|
    attachable.variant :small, resize_to_limit: [160, 160]
  end

  has_and_belongs_to_many :joined_events,
                          class_name: 'Event',
                          association_foreign_key: 'event_id'

  def full_name
    "#{first_name} #{last_name}"
  end
end
