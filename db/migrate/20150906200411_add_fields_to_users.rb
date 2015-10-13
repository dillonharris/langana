class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :integer
    add_column :users, :service, :string
    add_column :users, :home_language, :string
    add_column :users, :second_language, :string
    add_column :users, :third_language, :string
    add_column :users, :id_or_passport_number, :string
    add_column :users, :id_or_passport_image, :string
    add_column :users, :country_of_citizenship, :string
    add_column :users, :work_permit_status, :string
    add_column :users, :work_permit_image, :string
    add_column :users, :street_address, :string
    add_column :users, :unit, :string
    add_column :users, :suburb, :string
    add_column :users, :city, :string
    add_column :users, :province, :string
    add_column :users, :postal_code, :string
    add_column :users, :country, :string
    add_column :users, :drivers_license, :string
  end
end
