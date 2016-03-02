class AddCategoryToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :category, :integer
  end
end
