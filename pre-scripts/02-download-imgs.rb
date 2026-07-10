#!/bin/env ruby
require 'fileutils'

urls = File.read('results.txt').split("\n")
urls.each do |url|
  if url =~ /(\d+)\/([^\/]+?)$/
    dir, filename = $1, $2
    FileUtils.mkdir_p("icons/#{dir}")
    output = "icons/#{dir}/#{filename}"
    puts "#{url} -> #{output}"
    if File.exist?(output)
      puts "👍 File already exists, skipping download"
    else
      `wget --quiet --output-document=#{output} #{url}`
    end
  else
    puts "⚠️ Could not parse URL #{url}"
  end
end
