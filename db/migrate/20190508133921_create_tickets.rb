class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.string :status
      t.datetime :starting_at
      t.datetime :expiry_at
      t.datetime :reminder_at
      t.string :reminder_description
      t.references :board, foreign_key: true

      t.timestamps
    end
  end
end
