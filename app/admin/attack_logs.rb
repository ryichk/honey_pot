ActiveAdmin.register AttackLog do
  permit_params :ip_address, :trap_triggered_at

  index do
    selectable_column
    id_column
    column :ip_address
    column :trap_triggered_at
    actions
  end

  filter :ip_address
  filter :trap_triggered_at

  form do |f|
    f.inputs do
      f.input :ip_address
      f.input :trap_triggered_at
    end
    f.actions
  end
end
