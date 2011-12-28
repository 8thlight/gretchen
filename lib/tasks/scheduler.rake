desc "This task is called by the Heroku scheduler add-on"
task :reminder_email => :environment do
    puts "Checking for reminders"
      VacationMailer.remind(Time.now)
    puts "done."
end
