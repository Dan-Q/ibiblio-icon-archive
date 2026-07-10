#!/bin/env ruby
require 'uri'
require 'net/http'

File.open('results.txt', 'w') do |f|
  urls = (1..114).flat_map { |i|
    %w{36 108 180 252 324 396 468 540}.flat_map { |x|
      %w{44 133 222 311 400 489 578 667}.flat_map { |y|
        "https://www.ibiblio.org/iconbin/imagemap/icon#{i}?#{x},#{y}"
      }
    }
  }

  # For each URL, make a HTTP request and expect a HTTP 302 response with a Location: pointing to the
  # REAL URL. Write these to our file.
  urls.each do |url|
    print url
    uri = URI(url)
    res = Net::HTTP.get_response(uri)
    if res.code == '302'
      if res['location'].end_with?('/none.html')
        puts " -> ⚠️ FAILED! Redirects to #{res['location']}"
      else
        puts " -> #{res['location']}"
        f.puts res['location']
      end
    else
      puts " -> ⚠️ FAILED! HTTP response code #{res.code}"
      nil # Not sure what to do for the best if this happens! Let's ignore for now.
    end
  end
end
