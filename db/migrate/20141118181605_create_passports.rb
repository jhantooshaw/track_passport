class CreatePassports < ActiveRecord::Migration
  def change
    create_table :passports do |t|
      t.string      :first_name
      t.string      :last_name
      t.date        :dob
      t.string      :email
      t.string      :mobile
      t.string      :number
      t.date        :expiry_date
      t.string      :status,              default: 'ready_to_start'
      t.string      :unique_number
      t.timestamps
    end
    
    add_index :passports, :dob
    add_index :passports, :email
    add_index :passports, :mobile
    add_index :passports, :number,            unique: true    
    add_index :passports, :unique_number,     unique: true
    add_index :passports, :status
    
  end
end
