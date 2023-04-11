class CreateIpLists < ActiveRecord::Migration[6.1]
  def change
    create_table :ip_lists do |t|
      t.string :ip_address
      t.string :list_type

      t.timestamps
    end
  end
end
