ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :username, :name, :bio, :bluetick

  filter :email
  filter :username
  filter :name
  filter :bio 
  filter :followees
  filter :followers

  actions :all
 
  index do
    selectable_column
    id_column
    column :email
    column :username
    column :name
    column :bio
    column :bluetick
    column :created_at
    column :updated_at
    column 'followees' do |obj|
      obj.followees.count
    end 
    column 'followers' do |obj|
      obj.followers.count
    end
    actions
  end

  show do
    attributes_table do
      row :email
      row :created_at
      row :username
      row :name
      row :bluetick
      row :photo do |p|
        image_tag p.photo, :size => "200x200" 
      end
      row 'followees' do |obj|
        obj.followees.count
      end 
      row 'followers' do |obj|
        obj.followers.count
      end
      row 'tweets' do |obj|
        link_to "User's Tweets", admin_user_tweets_path(user)
      end
    end
  end

  form  do |f|
    f.inputs do
      f.input :email, input_html: { disabled: true } 
      f.input :username, input_html: { disabled: true } 
      f.input :name, input_html: { disabled: true } 
      f.input :bio, input_html: { disabled: true } 
      f.input :bluetick, as: :boolean
      f.input :photo, as: :file, hint: image_tag(f.object.photo), :size => "200x200" 
    end
    f.actions
  end

  scope :all
  scope :bluetick do |prs|
    prs.where(:bluetick => 'true')
  end

  controller do
    def scoped_collection
      Tweet.unscoped{super}
    end
  end

end

