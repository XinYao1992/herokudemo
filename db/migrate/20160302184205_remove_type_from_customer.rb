class RemoveTypeFromCustomer < ActiveRecord::Migration
  def change
    remove_column :customers, :type, :integer
  end
end
