require "twitter"
require "pp"

#ENV["SSL_CERT_FILE"] = "~/cacert.pem"

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['consumer_key'] 
      config.consumer_secret     = ENV['consumer_secret']
      config.access_token        = ENV['access_token']
      config.access_token_secret = ENV['access_token_secret']
    end

#client.update("I thought what I'd do was, I'd pretend I was one of those deaf-mutes")
	tl = client.home_timeline
#pp tl
#client.home_timeline.each do |tweet|
#    puts tweet.user.screen_name + ':' + tweet.text
#end


#3.times do
#	10.times do
#		client.follow(kakedasi_user_array5.shift)
#	end
#	sleep(900)
#end

#user = []
#client.search(ARGV[0]).take(10).each do|tweet|
#  pp tweet.user.screen_name + ':' + tweet.text
#  user << tweet.user.screen_name
#end

#client.search("技術書典5", result_type: "recent").take(500).collect do |tweet|
#  "#{tweet.user.screen_name}: #{tweet.text}"
# "#{tweet.user.screen_name}: #{tweet.text}"
#   p "#{tweet.user.screen_name}"
#end

#Twitter.list_add_members('wayaqu', 'hoge', user)
pp client.list('hoge') 
#pp client.add_list_member("hoge",["yanaka2"])
#pp client.add_list_members("hoge",["pcpc193", "takuya_qiita"])

#pp client.add_list_members("python",user)
#pp ARGV[0]
#pp user


#user.each do |use|
#client.create_list('hoge')
#client.list_add_members('hoge',user)
#end
#client.list_add_members("wayaqu", "Python", user)

#pp user
