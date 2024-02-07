ActiveAdmin.register Tweet do

  belongs_to :user

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :content, :likescount, :user_id, :report

  filter :content
  filter :likescount
  filter :user_id
  filter :report

  actions :all
  RESTRICTED_ACTIONS = ["new"]

  index do
    selectable_column
    id_column
    column :content
    column :user_id
    column :user
    column :report
    actions
  end

  show do
    tabs do
      tab :Tweet do
        attributes_table do
          row :user
          row :content
          row :likescount
          row "Comment's Count" do |c|
            c.comments.count
          end
          row "Images" do |p|
            p.images.map do |photo|    
              if photo.content_type.include?("image")
                image_tag url_for(photo), :size => "200x200"
              else
                video_tag url_for(photo), :size => "200x200" ,autoplay: true, muted: 'muted', loop: :loop
              end
            end
          end
        end
      end
      tab :Comments do
        attributes_table do
          row :content
          row "Comment's Count" do |c|
            c.comments.count
          end
          row 'Comments' do |i|
            ul do
              tweet.comments.each do |com|
                li com.user.name + " : " + com.body
              end
            end
          end
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :user_id, input_html: { disabled: true } 
      f.input :content, input_html: { disabled: true } 
      f.input :user, input_html: {disabled: true }
      f.input :report, as: :boolean
    end
    if tweet.images.attached?
      ul do
        tweet.images.map do |photo|
          li do
            if photo.content_type.include?("image")
              image_tag url_for(photo), :size => "200x200" 
            else
              video_tag url_for(photo), :size => "200x200" ,autoplay: true, muted: 'muted', loop: :loop
             end
           end
        end
      end
    end
    f.actions
  end

  batch_action :report do |ids|
    batch_action_collection.unscoped.find(ids).each do |tweet|
      tweet.report = true
      tweet.save
    end
    redirect_to admin_user_tweets_path, alert: "The tweets have been reported."
  end

  batch_action :unreport do |ids|
    batch_action_collection.unscoped.find(ids).each do |tweet|
      tweet.report = false
      tweet.save
    end
    redirect_to admin_user_tweets_path, alert: "The tweets have been unreported."
  end

  member_action :change_month, method: :get do
    date = params[:month].to_date
    hsh = {}
    count = Tweet.where('created_at BETWEEN ? AND  ?', date.beginning_of_month, date.end_of_month).group_by_week(:created_at).count
    # hsh.store("#{params[:month].to_date.strftime("%B")}", count)
    count.present? ? count : count = []
    render json: count
  end

  controller do
    def action_methods
      super - RESTRICTED_ACTIONS
    end    
    
    def index
      super do
        @tweets = @tweets.unscoped.where(user_id: @user.id).page(params[:page]).per(10) 
      end
    end

    def edit
      @tweet = Tweet.unscoped.find(params[:id])
      super 
    end

    def update
      @tweet = Tweet.unscoped.find(params[:id])
      @tweet.update(tweet_params)
      redirect_to admin_user_tweets_path
    end
    
    def show
      @tweet = Tweet.unscoped.find(params[:id])
      super
    end

    private
    def tweet_params
      params.require(:tweet).permit(:report)
    end

  end
end
