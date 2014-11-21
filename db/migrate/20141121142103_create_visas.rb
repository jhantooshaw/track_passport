class CreateVisas < ActiveRecord::Migration
  def change
    create_table :visas do |t|
      t.string      :status,              default: 'under_process'
      t.string      :unique_number
      t.string      :visa_type
      t.boolean     :is_deleted,          default: false
      t.references  :passport
      t.timestamps
    end
  end
end
