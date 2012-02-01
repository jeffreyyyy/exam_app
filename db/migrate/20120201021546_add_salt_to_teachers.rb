class AddSaltToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :salt, :string

  end
end
