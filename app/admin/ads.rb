ActiveAdmin.register Ad do
  require 'open-uri'
  permit_params :priorkey, :details, ads_images: []
  filter :priorkey
  actions :all
  RESTRICTED_ACTIONS = ["new"]
 
  action_item only: :index do
    link_to 'Upload CSV', action: 'upload_csv' if Ad.all.count < 5
  end

  collection_action :upload_csv do
    render 'admin/csv/upload_csv'
  end

  collection_action :import_csv, method: :post do
    redirect_to({ action: :index}, flash: { notice: "Incorrect file format"}) and return if params[:dump][:file].content_type != "text/csv"
    ads = CsvHelper.convert_to_ads(params[:dump][:file])
    
    if !ads.present?
      redirect_to({ action: :index}, flash: { notice: 'successfully imported'} )
    else
      redirect_to({ action: :index }, flash: { error: ads})
    end
  end

  index do
    selectable_column
    id_column
    column :priorkey
    column :details do |d|
      d.details.html_safe
    end
    column 'Images' do |p| 
      p.ads_images.map do |photo|
        if photo.content_type.include?("image")
          image_tag url_for(photo), :size => "80x80" 
        else
          video_tag url_for(photo), :size => "80x80" ,autoplay: true, muted: 'muted', loop: :loop
        end  
      end
    end
    actions
  end

  show do
    attributes_table do
      row :details do |d|
        d.details.html_safe
      end
      row :priorkey
      row "Images" do |p|
        p.ads_images.map do |photo|    
          if photo.content_type.include?("image")
            image_tag url_for(photo), :size => "200x200" 
          else
            video_tag url_for(photo), :size => "200x200" ,autoplay: true, muted: 'muted', loop: :loop
          end
        end
      end
    end
  end


  form do |f|
    f.inputs do
      f.input :priorkey, as: :select, collection: Ad::STATUSES.invert, :prompt => "Select Priority"
      f.input :details, as: :quill_editor
      f.input :ads_images, as: :file, input_html: { multiple: true }
    end
    if ad.ads_images.attached?
      ad.ads_images.map do |photo|
        if photo.content_type.include?("image")
          image_tag url_for(photo), :size => "200x200" 
        else
          video_tag url_for(photo), :size => "200x200" ,autoplay: true, muted: 'muted', loop: :loop
        end
      end
    end
    f.actions
  end
 
  controller do
    def action_methods
      if Ad.all.count >= 5
        super - RESTRICTED_ACTIONS
      else
        super 
      end

    end
  end
end
