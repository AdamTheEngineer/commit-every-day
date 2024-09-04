require 'date'

file = File.read('pattern.txt')
flat_pattern = file.split("\n").map{|line| line.split(//)}.transpose.map(&:join).join

start_date = Date.new(2024,5,5)
end_date = Date.new(2026,1,1)

dates = start_date.upto(end_date).to_a

commit_dates = []
dates.each_with_index do |date, index|
  pattern_index = index % flat_pattern.length
  if flat_pattern[pattern_index] == 'A'
    2.times{|i| commit_dates << date.to_time + (4*3600) + (i * 360)}
  end
end

str_commit_dates = commit_dates.map(&:to_s)

name = "Adam Duke"
email = "adam.v.duke+engineer@gmail.com"
commit_dates.each do |date|
  puts date
  File.open('output.txt', 'w') { |f| f << str_commit_dates.shuffle.first(6).join("\n") }
  `GIT_AUTHOR_DATE="#{date}" GIT_COMMITTER_DATE="#{date}" GIT_COMMITTER_NAME="#{name}" GIT_COMMITTER_EMAIL="#{email}" GIT_AUTHOR_NAME="#{name}" GIT_AUTHOR_EMAIL="#{email}" git commit -am "#{date}"`
end
