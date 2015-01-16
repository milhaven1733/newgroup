user = "brtr"                                                                                                                                                                    
application = "group"          
 
port 5000
threads 0, 4                   
workers 1
      
pidfile "/home/#{user}/apps/#{application}/shared/tmp/pids/puma.#{application}.pid"
      
preload_app!
on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end 
end
