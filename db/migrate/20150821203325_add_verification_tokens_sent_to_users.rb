class AddVerificationTokensSentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verification_tokens_sent, :integer, default: 0
  end
end
