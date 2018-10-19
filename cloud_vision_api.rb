#! /usr/bin/env ruby

require 'base64'
require 'json'
require 'net/https'

IMAGE_FILE = ARGV[0]

API_KEY = ENV['GOOGLE_VISION_API_KEY'] 
API_URL = "https://vision.googleapis.com/v1/images:annotate?key=#{API_KEY}"

# 画像をbase64にエンコード
base64_image = Base64.strict_encode64(File.new(IMAGE_FILE, 'rb').read)

# APIリクエスト用のJSONパラメータの組み立て
body = {
  requests: [{
    image: {
      content: base64_image
    },
    features: [
      {
#        type: 'LABEL_DETECTION',
        type: 'TEXT_DETECTION',
        maxResults: 5
      }
    ]
  }]
}.to_json

# Google Cloud Vision APIにリクエスト投げる
uri = URI.parse(API_URL)
https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true
request = Net::HTTP::Post.new(uri.request_uri)
request["Content-Type"] = "application/json"
response = https.request(request, body)

# APIレスポンス出力
puts response.body
