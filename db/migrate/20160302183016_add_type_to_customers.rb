class AddTypeToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :type, :integer

  end
end
