require 'nokogiri'
require 'pp'
require 'csv'

doc = File.open("/Users/lewisparker/Dropbox/EarthVectors/Projects/Internal/code/1410_2024/Scouting1410/scripts/scratch_1.html") { |f| Nokogiri::HTML(f) }

data = []
count = 0
doc.css('.row').each do |row|
  divs = row.search('div')
  img = divs.shift.search('img')
  data << divs.map(&:text).push(img.attr('src').content)
  # count += 1
  # if count > 9
  #   break
  # end
end

CSV.open('frc_teams.csv', 'w') do |csv|
  csv << ['Number', 'Name', 'Type', 'Location', 'Logo']
  data.each do |row|
    csv << row
  end
end

