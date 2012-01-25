class AddEmailUniquenessIndex < ActiveRecord::Migration
  def up
    add_index :teachers, :email, :unique => true
  end

  def down
    remove_index :teachers, :email
  end
end
