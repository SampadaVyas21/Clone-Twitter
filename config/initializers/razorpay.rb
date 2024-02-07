require 'razorpay'
key_id  = "#{ENV['razorpay_id']}"
secret_key = "#{ENV['razorpay_secret_key']}"
Razorpay.setup(key_id, secret_key)