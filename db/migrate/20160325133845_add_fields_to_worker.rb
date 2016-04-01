class AddFieldsToWorker < ActiveRecord::Migration
  def change
    add_column :workers, :first_name, :string
    add_column :workers, :last_name, :string
    add_column :workers, :mobile_number, :string
    add_column :workers, :email, :string
    add_column :workers, :password_digest, :string
    add_column :workers, :profile_picture, :string
    add_column :workers, :role, :integer
  end
end
