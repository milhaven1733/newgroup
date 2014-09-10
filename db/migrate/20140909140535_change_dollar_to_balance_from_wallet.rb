class ChangeDollarToBalanceFromWallet < ActiveRecord::Migration
  def change
    rename_column :wallets, :dollar_in_cents, :balance_in_cents
  end
end
