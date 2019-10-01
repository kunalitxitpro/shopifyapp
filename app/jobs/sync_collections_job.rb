class SyncCollectionsJob < ApplicationJob
  queue_as :default

  def perform
    ShopifyApiConnector.new.refresh_collections
  end
end
