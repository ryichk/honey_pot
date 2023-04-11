ActiveAdmin.register IpList do
  permit_params :ip_address, :list_type

  index do
    selectable_column
    id_column
    column :ip_address
    column :list_type
    actions
  end

  filter :ip_address
  filter :list_type, as: :select, collection: ['blocked', 'trusted']

  form do |f|
    f.inputs do
      f.input :ip_address
      f.input :list_type, as: :select, collection: ['blocked', 'trusted']
    end
    f.actions
  end
end
