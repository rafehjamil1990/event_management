# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.integer :available_slots
      t.integer :total_slots

      t.decimal :lat, precision: 10, scale: 6
      t.decimal :long, precision: 10, scale: 6

      t.references :user

      t.timestamps
    end
  end
end
