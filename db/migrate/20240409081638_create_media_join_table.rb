# frozen_string_literal: true

class CreateMediaJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :events do |t|
      # t.index [:user_id, :event_id]
      t.index %i[event_id user_id], unique: true
    end
  end
end
