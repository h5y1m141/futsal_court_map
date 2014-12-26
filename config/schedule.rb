set :environment, :development
set :output, {:error => 'log/error.log', :standard => 'log/cron.log'}

every 5.minute do
  command "echo 'you can use raw cron syntax too'"
  runner "Tasks::Crawl.execute"
end
