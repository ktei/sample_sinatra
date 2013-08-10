class CreateFoos < ActiveRecord::Migration
  def up
    create_table :foos do |t|
      t.string :name
    end
  end

  def down
    drop_table :foos
  end
end
