class HardWorkerJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    Rails.logger.debug("-------Starting working job------")
    User.create!(:email =>  Faker::Internet.email, :password => "000000")
    Rails.logger.debug("-------Ending working job------")
  end
end
