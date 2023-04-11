class CreateAttackLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :attack_logs do |t|
      t.string :ip_address
      t.datetime :trap_triggered_at

      t.timestamps
    end
  end
end
