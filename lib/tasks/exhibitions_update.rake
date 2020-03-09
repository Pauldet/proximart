namespace :exhibitions do
  desc "Updates the database of exhibitions"
  task update: :environment do
    puts "task starting"
    UpdateDataBaseJob.perform_now
    puts "task done"
  end

end
