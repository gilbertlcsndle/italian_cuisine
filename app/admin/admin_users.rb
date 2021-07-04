ActiveAdmin.register AdminUser do
  actions :index

  index do
    column :email
    column :current_sign_in_at
    column :sign_in_count
  end

  show do
    attributes_table do
      row :email
      row :current_sign_in_at
      row :sign_in_count
    end
  end
end
