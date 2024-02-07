class Subscription < ApplicationRecord
	enum plan: [:gold, :silver, :platinum]
end
