# frozen_string_literal: true

class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
