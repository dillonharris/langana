class AddMoreFieldsToWorker < ActiveRecord::Migration
  def change
    add_column :workers, :gender, :integer
    add_column :workers, :service, :string
    add_column :workers, :home_language, :string
    add_column :workers, :second_language, :string
    add_column :workers, :third_language, :string
    add_column :workers, :id_or_passport_number, :string
    add_column :workers, :id_or_passport_image, :string
    add_column :workers, :country_of_citizenship, :string
    add_column :workers, :work_permit_status, :string
    add_column :workers, :work_permit_image, :string
    add_column :workers, :street_address, :string
    add_column :workers, :unit, :string
    add_column :workers, :suburb, :string
    add_column :workers, :city, :string
    add_column :workers, :province, :string
    add_column :workers, :postal_code, :string
    add_column :workers, :country, :string
    add_column :workers, :drivers_license, :string
  end
end
