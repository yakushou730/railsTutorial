#json.events @events

#json.custom_events @events do |event|
#  json.id event.id
#  json.name event.name
#end

json.custom_events @events do |e|
  json.partial! 'details', event: e
end