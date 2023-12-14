class UserMailer < ApplicationMailer
	default from: "from@example.com"

	def liked_email
    @tweet = params[:tweet]
    @user = params[:user]
    attachments.inline['Default_Tweet_Button.png'] = File.read('app/assets/images/Default_Tweet_Button.png')
    mail(to: @tweet.user.email, subject: 'your tweet received a like')
  end

  def commented_email
  	@tweet = params[:tweet]
    @user = params[:user]
    @comment = params[:comment]
    attachments.inline['Default_Tweet_Button.png'] = File.read('app/assets/images/Default_Tweet_Button.png')
    mail(to: @tweet.user.email, subject: 'your tweet received a comment')
  end

  def follwed_email
  	@followee = params[:followee]
  	@follower = params[:follower]
    attachments.inline['Default_Tweet_Button.png'] = File.read('app/assets/images/Default_Tweet_Button.png')
    mail(to: @followee.email, subject: 'your tweet received a new follower')
  end

end
