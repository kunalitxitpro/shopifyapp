CarrierWave.configure do |config|

  if ENV['RAILS_ENV'] == 'production'
    config.fog_credentials = {
         provider:               'AWS',
         aws_access_key_id:      ENV['AWS_KEY'],
         aws_secret_access_key:  ENV['AWS_SECRET'],
         region:                 'us-east-1'
     }
     config.fog_public     = true
     config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
     config.fog_directory  = ENV['S3_BUCKET']
  else
    config.storage = :file
  end
end
