class ChangeColumnNameAtTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :image_url, :string
    add_column    :tickets, :image, :string
  end
end
