#!/usr/bin/env ruby
require 'erb'
require 'json'

# Constants
CACHED_ICON_METADATA_VALID_FOR = 86_400 # 1 day

# Load templates
TEMPLATE = {
  collection: ERB.new(File.read('templates/collection.html.erb')),
  index:      ERB.new(File.read('templates/index.html.erb')),
}

# Get collections
Dir.chdir('icons')
collections = Dir.glob('*').filter{|d|File.directory?(d)}.map(&:to_i).sort
Dir.chdir('..')

# Store every icon we check
all_icons = []

# Build collection pages
collections.each_with_index do |collection, collection_index|
  html_file = "icons/#{collection}.html"
  puts "Building page #{html_file}..."
  icons = Dir.glob("icons/#{collection}/*.gif").map do |icon_file|
    cached_metadata_file = "#{icon_file}.json"
    if(File.exist?(cached_metadata_file) && ((Time.now - File.mtime(cached_metadata_file)) < CACHED_ICON_METADATA_VALID_FOR))
      # If we have recent pre-cached metadata for this icon, use that (faster than `magick identify`)
      JSON.parse(File.read(cached_metadata_file))
    else
      magick_raw_results = `magick identify "#{icon_file}"`
      magick_results = magick_raw_results.split(/\s/)
      if(magick_results.length >= 3)
        result = {
          'name' => icon_file,
          'size' => magick_results[2].split('x'),
          'page' => collection_index + 1,
        }
        File.open(cached_metadata_file, 'w') do |f|
          f.puts(JSON.generate(result))
        end
        result
      else
        puts "⚠️👆 That doesn't look right!"
        {
          'name' => icon_file,
          'size' => [], # unknown
          'page' => collection_index + 1,
        }
      end
    end
  end
  all_icons.concat(icons)
  File.open(html_file, 'w') do |f|
    f.puts TEMPLATE[:collection].result(binding)
  end
end

# Build homepage
puts "Building index.html..."
File.open("index.html", 'w') do |f|
  f.puts TEMPLATE[:index].result(binding)
end
