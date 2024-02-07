class SubscriptionsController < ApplicationController
require 'razorpay'
skip_before_action :verify_authenticity_token
	def subs_plans
		@subscriptions = Subscription.all
		@subscriptions.each do |sub|
			sub.update(validity: Date.today + 9.months) if sub.id == 1 
			sub.update(validity: Date.today + 6.months) if sub.id == 2 
			sub.update(validity: Date.today + 3.months) if sub.id == 3 
		end
	end

	def razorpay_p
		@subscription = Subscription.find_by(id: params[:id])
		@order = Razorpay::Order.create amount: @subscription.price.to_i * 100, currency: 'INR', receipt: 'TEST'
	end

	def subscription_v
		@subscription = Subscription.find_by(id: params[:id])
		@payment = Razorpay::Payment.fetch(params[:razorpay_payment_id])
		if @payment.present?
			UserSubscription.create(user_id: current_user.id, plan: @subscription.plan, validity: @subscription.validity, activated: true, price: @subscription.price)
			redirect_to subscription_plans_path
		else
			 redirect_to subscription_plans_path, alert: "Could not verify payment."
		end			
	end
end
