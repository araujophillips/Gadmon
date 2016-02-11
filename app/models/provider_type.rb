class ProviderType < ActiveRecord::Base
	has_many :providers, :dependent => :destroy
end
