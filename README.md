# README

Shopify Search App

How to get the app running:

* Get an ngrok server pointing to localhost 3000

* Change the ngrok asset host to the ngrok address eg. config.action_controller.asset_host = "https://42c86952.ngrok.io"

* In the app configuration on Shopify set the admin redirect url to the ngrok address and change the proxy to the address but with the extension shopifyapp/products

* Run rake jobs:add_and_update_products (to get a local copy of the products)

* In the admin app set true search to true

* Testing can be done on the search field which from the script will auto-populate the results and then after searching would direct the user to the proxy page
