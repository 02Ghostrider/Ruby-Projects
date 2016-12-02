#event_manager

require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone(phone_number)
	number = phone_number.scan(/\d+/).join('')
	if number.length < 10 || number.length > 11
		phone = %w{0000000000}
	elsif number.length == 11 && number[0] == 1
		phone = number[1..11]
	elsif number.length == 11 && number[0] != 1
		phone = %w{0000000000}
	else
		phone = number
	end
end

def clean_name(raw_name)
	nombre = raw_name.split
	nombre.each do |n| 
		n.downcase.capitalize
	end
	nombre.join(" ")
end

def registration_times(regdate) 
	reg_date_time = regdate.split
	timestamp = reg_date_time[1].split(':')
	hour = timestamp[0].to_i
end

def sorted(hash)
	hash = hash.sort_by {|a, b| b }
	hash.reverse!
end

def registration_days(regdate)
	reg_date_time = regdate.split
	bad_date = reg_date_time[0].split('/')
	foo_date = bad_date.rotate(-1)
	bar_date = foo_date.each {|x| x.to_i}
	reg_date = Time.new(bar_date[0], bar_date[1], bar_date[2])
	reg_day = reg_date.wday
end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id,form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

hours = Hash.new(0)
days = Hash.new(0)

contents.each do |row|
  id = row[0]
  name = clean_name(row[:first_name])
  zipcode = clean_zipcode(row[:zipcode])
  phone = clean_phone(row[:homephone])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id,form_letter)

  hours[registration_times(row[:regdate])] += 1
  days[registration_days(row[:regdate])] += 1
end

best_hours = sorted(hours)
best_days = sorted(days)

puts "Registration times: #{best_hours}"
puts "Registration days: #{best_days}"
