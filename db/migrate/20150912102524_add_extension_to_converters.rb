class AddExtensionToConverters < ActiveRecord::Migration
  def change
    add_column :converters, :extension, :string
  end
end
