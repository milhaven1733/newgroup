class SetupWalletForOriginUsers < ActiveRecord::Migration
  def change
    say "migrate origin user to create wallet"
    User.find_each do |u|
      u.send(:init_wallet) unless u.wallet
    end
  end
end
