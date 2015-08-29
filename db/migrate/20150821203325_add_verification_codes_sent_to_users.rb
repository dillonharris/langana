class AddVerificationCodesSentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verification_codes_sent, :integer, default: 0
  end
end
