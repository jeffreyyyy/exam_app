class AddPasswordToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :encrypted_password, :string

  end
end
