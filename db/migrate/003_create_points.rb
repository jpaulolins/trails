class CreatePoints < ActiveRecord::Migration
  def self.up
    create_table :points do |t|
      t.string :lt
      t.string :lg
      t.string :velocity
      t.references :trail
      t.timestamps
    end
  end

  def self.down
    drop_table :points
  end
end
