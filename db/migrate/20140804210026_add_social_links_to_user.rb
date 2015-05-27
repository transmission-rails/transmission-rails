class AddSocialLinksToUser < ActiveRecord::Migration
  def change
    add_column :users, :skype, :string
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
    add_column :users, :linkedin, :string
  end
end
