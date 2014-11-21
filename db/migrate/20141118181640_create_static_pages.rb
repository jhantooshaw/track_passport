class CreateStaticPages < ActiveRecord::Migration
  def change
    create_table :static_pages do |t|
      t.string      :page_id
      t.string      :name
      t.text        :content
      t.boolean     :active,        :default => true
      t.timestamps
    end
  end
end
