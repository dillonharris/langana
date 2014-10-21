class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :direction
      t.string :work
      t.text :comment
      t.references :reviewed, index: true
      t.references :reference, index: true

      t.timestamps
    end
  end
end
