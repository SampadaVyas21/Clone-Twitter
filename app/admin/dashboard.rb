# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #

      columns do
        
        column do
          panel "Tweet content: " do
            pie_chart Tweet.group(:content).count, donut: true, cutoutPercentage: 75
          end
        end


        column do
          panel "Tweet content: " do
            bar_chart Tweet.group(:content).count
          end
        end

        column do
          panel "Tweet content: " do
            line_chart Tweet.group(:content).count
          end
        end
      end

      columns do

        column do
          panel "months" do 
            render "admin/chartkick"
            # select :months, :class => 'selected_month' do 
            #   %w(January February March April May June July August September October November December).each do |opt|
            #     option opt, :value => opt, remote: true ,
            #     script: (document).on("click", option(){
            #               debugger
            #             });
            #   end
            # end
            # ul do
            #   bar_chart Tweet.group_by_month(:created_at, format: "%B").count
            # end
          end
        end
      end

      columns do

        column do
          panel "user with most tweets" do
            hsh = {}
            Tweet.all.each{|a| hsh = hsh.merge("#{a.user.name}": Tweet.where(user_id: a.user_id).count)}
            bar_chart hsh
          end
        end

        column do
          panel "Tweet with number of likes " do
            bar_chart Like.group(:tweet_id).count
          end
        end

        column do
          panel "Tweet based on comments count " do
            bar_chart Comment.group(:tweet_id).count
          end
        end

        column do
          panel "Tweets which are retweeted" do
            bar_chart Retweet.group(:tweet_id).count
          end
        end
      end

      columns do

        column do
          panel "Tweet based on likescount " do
            bar_chart Tweet.group(:likescount).count
          end
        end

        column do
          area_chart Tweet.group(:content).count
        end

        column do
          column_chart Tweet.group(:content).count
        end

      end

      columns do

        column do
          panel "Total Users:   #{User.all.count}" do
            ul do
              User.all.each do |user|
                li user.name
              end
            end
          end
        end

        column do
          panel "Verified Users: " do
            ul do
              c = 0
              User.all.each do |user|
                 if user.bluetick
                  li user.name
                  c = c + 1 
                end  
              end
              para "Total number of Verified Users:  #{c}"
            end
          end
        end

        column do
          panel "Total Tweets: #{Tweet.all.count}" do
            para " Recent 5 Tweets: "
            ul do
              Tweet.last(5).map do |post|
                li post.user.name + " : " + post.content
              end
            end
          end
        end

        column do
          panel "Total Retweets :  #{Retweet.all.count}" do
          para " Recent 5 Retweets: "
            ul do
              Retweet.last(5).map do |post|
                li post.tweet.user.name + " : " + post.tweet.content
              end
            end
          end
        end

        column do
          panel "Users with total number of Tweets: " do
            ul do
              User.all.each do |user|
                li user.name + " : #{user.tweets.count}"   
              end
            end
          end
        end
      end
  end 
end
