class CreateLuvs < ActiveRecord::Migration
  def self.up
    create_table :luvs do |t|
      t.references :user
      t.references :project

      t.timestamps
    end
  end

  def self.down
    drop_table :luvs
  end
end
