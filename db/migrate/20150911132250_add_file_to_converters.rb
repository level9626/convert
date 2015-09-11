class AddFileToConverters < ActiveRecord::Migration
  def change
    add_column :converters, :file, :string
  end
end
