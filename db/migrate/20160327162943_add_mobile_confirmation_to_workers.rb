class AddMobileConfirmationToWorkers < ActiveRecord::Migration
  def change
    add_column :workers, :mobile_confirmation_code_digest, :string
    add_column :workers, :mobile_code_salt, :string
    add_column :workers, :mobile_confirmation_sent_at, :datetime
    add_column :workers, :confirmed_at, :datetime
    add_column :workers, :unconfirmed_mobile_number, :string
    add_column :workers, :confirmation_attempts, :integer, default: 0
  end
end
