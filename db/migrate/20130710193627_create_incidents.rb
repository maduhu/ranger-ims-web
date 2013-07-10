class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.integer :servernum
      t.string :etag
      t.text :source

      t.timestamps
    end
  end
end
