#!/usr/bin/env ruby
# coding: utf-8

require 'date'
require 'fileutils'

d = Date.today
d = Date.parse(ARGV[0]) if ARGV.size > 0
n_d = d.next_month(1)
n_d = Date.parse(ARGV[1]) if ARGV.size > 1

df = d.strftime('%Y-%m-%d')
n_df = n_d.strftime('%Y-%m-%d')

dir_path = "reports/#{df}_#{n_df}"

Dir.mkdir(dir_path) unless Dir.exist?(dir_path)

temp_text = File.read('./template.md')

i = 1
cur = d
while cur < n_d
  fp = "#{dir_path}/#{i}.md"
  File.write(fp, temp_text.gsub(/<title>/, "#{cur}〜#{cur.next_day(6)}")) unless File.exist?(fp)
  cur = cur.next_day(7)
  i += 1
end
