set :user, 'rushour_staging'
server 'ec2-yyy-yyy-yyy-yyy.us-east-1.compute.amazonaws.com', :app, :web, :db, :primary => true
#ssh_options[:keys] = ["#{ENV['HOME']}/Path/To/StagKey/ec2-stag-key.pem"]
ssh_options[:forward_agent] = true
