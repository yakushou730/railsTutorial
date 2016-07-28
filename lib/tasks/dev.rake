namespace :dev do

  task :rebuild => ["db:drop", "db:setup", :fake]

  #task :rebuild => ["db:drop", "db:create", "db:schema:load", "db:seed", :fake]

  task :fake => :environment do
    User.delete_all
    Event.delete_all
    Attendee.delete_all

    puts "Creating fake data!"

    user = User.create!(:email => "yakushou730@gmail.com", :password => "000000")

    50.times do |i|
      e = Event.create(:name => Faker::App.name)
      10.times do |j|
        e.attendees.create(:name => Faker::Name.name)
      end
    end

  end

  task :create_user => :environment do
    User.create!(:email =>  Faker::Internet.email, :password => "000000")
  end


  task :taipei_park => :environment do

    url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=8f6fcb24-290b-461d-9d34-72ed1b3f51f0"

    json_string = RestClient.get(url)

    data = JSON.parse(json_string)

    data["result"]["results"].each do |park|
      existing = Park.find_by_raw_id(park["_id"])
      if existing
        existing.update(:raw_id => park["_id"],
                    :parkname => park["ParkName"],
                    :administrativeArea => park["AdministrativeArea"],
                    :location => park["Location"],
                    :park_type => park["ParkType"],
                    :introduction => park["Introduction"])
      else
        Park.create(:raw_id => park["_id"],
                    :parkname => park["ParkName"],
                    :administrativeArea => park["AdministrativeArea"],
                    :location => park["Location"],
                    :park_type => park["ParkType"],
                    :introduction => park["Introduction"])
      end
    end

  end

  task :diip_mission => :environment do

    url = "http://1575d346.ngrok.io/api/v1/missions"
    json_string = RestClient.get(url)
    data = JSON.parse(json_string)

    data["custom_missions"].each do |mission|
      existing = Mission.find_by_raw_id(mission["mission"]["id"])
      if existing
        existing.update(:raw_id => mission["mission"]["id"],
                    :content => mission["mission"]["content"],
                    :unlock_level => mission["mission"]["unlock_level"],
                    :popular => mission["mission"]["popular"])
      else
        Mission.create(:raw_id => mission["mission"]["id"],
                    :content => mission["mission"]["content"],
                    :unlock_level => mission["mission"]["unlock_level"],
                    :popular => mission["mission"]["popular"])
      end


    end
  end
end