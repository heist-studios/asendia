require 'asendia/client'
require 'asendia/shipment'
require 'asendia/purchase_item'
require 'asendia/order'
require 'asendia/product'

# Include factories:
GEM_ROOT = File.dirname(File.dirname(__FILE__))
Dir[File.join(GEM_ROOT, 'spec', 'factories', '*.rb')].each do |file|
  require(file)
end
