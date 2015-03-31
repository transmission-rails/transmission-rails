class AddInitial < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :username
      t.string :password_hash
      t.string :salt

      t.timestamps
    end

    create_table :connections do |t|
      t.string :name
      t.string :host
      t.integer :port
      t.string :path
      t.boolean :ssl
      t.string :session_id
      t.integer :rpc_version
      t.boolean :credentials

      t.string :encrypted_username
      t.string :encrypted_password

      t.belongs_to :users

      t.timestamps
    end
  end
end
