class AddMobileConfirmationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mobile_confirmation_token_digest, :string
    add_column :users, :mobile_confirmation_sent_at, :datetime
    add_column :users, :confirmed_at, :datetime
    add_column :users, :unconfirmed_mobile_number, :string
  end
end
