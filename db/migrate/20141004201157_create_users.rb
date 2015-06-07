class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :mobile_number
      t.string :email
      t.string :password_digest
      t.string :profile_picture
      t.string :sms_confirmation_token_digest
      t.datetime :confirmed_at
      t.datetime :sms_confirmation_sent_at
      t.integer :role

      t.timestamps
    end
  end
end
