namespace :jobs do
  desc "Add all shopify products"
  task add_and_update_products: :environment do
    SyncProductsJob.perform_later
  end
end
