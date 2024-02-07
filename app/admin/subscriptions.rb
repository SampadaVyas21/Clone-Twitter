ActiveAdmin.register Subscription do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :plan, :validity, :price, :activated
  #
  # or
  #
  # permit_params do
  #   permitted = [:plan, :validity, :price, :activated]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  index do
    selectable_column
    id_column
    column :plan
    column :validity
    column :price
    column :activated
    actions
  end

  show do
    attributes_table do
      row :plan
      row :validity
      row :price
      row :activated
    end
  end


  form do |f|
    f.inputs do
      f.input :plan, as: :select
      f.input :validity, input_html: { disabled: true }
      f.input :price
      f.input :activated, as: :boolean
    end
    f.actions
  end
end
