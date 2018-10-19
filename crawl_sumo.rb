# ['mechanize','nokogiri','pp','benchmark'].each{|gem|require gem}
# $times = []
# class Abc
#   def self.aaa(html,min_num,max_num)
#     $times << Benchmark.realtime do
#       10000.times{puts "#{html}, #{min_num} #{max_num}"}
#     end
#   end

#   def self.bbb(number,html,min_num,max_num)
#     $times << Benchmark.realtime do
#       (number..10000).map{|num|puts "#{num}  #{html}, #{min_num} #{max_num}"}
#     end
#   end
# end
# # Abc::aaa("aaa","bbb","ccc")
# # Abc::bbb(0,"aaa","bbb","ccc")
# # $times.each{|time|puts "processing time #{time}s"}









['mechanize','nokogiri','pp','benchmark'].each{|gem|require gem}
$times = []
class Crowler
  def self.random_proxies
    ['au','melib.au','aus','bg','bul','br','ca','vanc.ca.west','cp','chil','cr','czech','den','egy','fin','fr','frank.gr',].sample.+(".torguardvpnaccess.com")
    ['au',].sample.+(".torguardvpnaccess.com")
  end

  def self.crawl(url,min_num,max_num)
    agent = Mechanize.new
    # agent.set_proxy('hoge.com', 6060, 'email%40example.com', 'password')
    @htmls ||= []; (min_num..max_num).map{|id|@htmls << agent.get(url+"#{id}").body}; @htmls
    # @htmls ||= []; $times<<Benchmark.realtime{   (min_num..max_num).map{|id|@htmls << agent.get(url+"#{id}").body}   }; @htmls
  end

  def self.parse(html,min_num,max_num)
    # $times << Benchmark.realtime do
      # @elements ||= []; $times<<Benchmark.realtime{   (0..max_num).map{|div_id|@elements << Nokogiri::HTML.parse(html).xpath("//*[@id='casset#{div_id}']/div/div[1]/div/h2/a").text}   }; @elements
      @elements ||= []; (min_num..max_num).map{|div_id|@elements << Nokogiri::HTML.parse(html).xpath("//*[@id='casset#{div_id}']/div/div[1]/div/h2/a").text}; @elements
      # @elements ||= []; $times<<Benchmark.realtime{   (0..max_num).map{|div_id|@elements << Nokogiri::HTML.parse(html).xpath("//*[@id='casset#{div_id}']/div/div[1]/div/h2/a").text}   }; @elements
    # end
  end
end
LIST_URL = "https://suumo.jp/jj/fudousan/ichiran/FR351FC001/?ar=030&bs=041&ta=13&sc=13101&sc=13102&sc=13103&sc=13104&sc=13105&sc=13106&sc=13107&sc=13108&sc=13109&sc=13110&sc=13111&sc=13112&sc=13113&sc=13114&sc=13115&sc=13116&sc=13117&sc=13118&sc=13119&sc=13120&sc=13121&sc=13122&sc=13123&sc=13201&sc=13202&sc=13203&sc=13204&sc=13205&sc=13206&sc=13207&sc=13208&sc=13209&sc=13210&sc=13211&sc=13212&sc=13213&sc=13214&sc=13215&sc=13218&sc=13219&sc=13220&sc=13221&sc=13222&sc=13223&sc=13224&sc=13225&sc=13227&sc=13228&sc=13229&pc=100&pn="
# Crowler::crawl(LIST_URL,1,1)
# @all_elements ||= []; Crowler::crawl(LIST_URL,1,2).each{|html|@all_elements << Crowler::parse(html,0,99)}
# @all_elements ||= []; File.open('tags.txt','w+'){|result|result << Crowler::crawl(LIST_URL,1,2).each{|html|@all_elements << Crowler::parse(html,0,99)}}
# File.open('tags.txt','w+'){|result|result << @all_elements}
# $times.each{|time|puts "processing time #{time}s"}


# LIST_URL = "https://suumo.jp/jj/fudousan/ichiran/FR351FC001/?ar=030&bs=041&ta=13&sc=13101&sc=13102&sc=13103&sc=13104&sc=13105&sc=13106&sc=13107&sc=13108&sc=13109&sc=13110&sc=13111&sc=13112&sc=13113&sc=13114&sc=13115&sc=13116&sc=13117&sc=13118&sc=13119&sc=13120&sc=13121&sc=13122&sc=13123&sc=13201&sc=13202&sc=13203&sc=13204&sc=13205&sc=13206&sc=13207&sc=13208&sc=13209&sc=13210&sc=13211&sc=13212&sc=13213&sc=13214&sc=13215&sc=13218&sc=13219&sc=13220&sc=13221&sc=13222&sc=13223&sc=13224&sc=13225&sc=13227&sc=13228&sc=13229&pc=100&pn="
# @all_elements ||= []; File.open('tags.txt','w+'){|result|result << Crowler::crawl(LIST_URL,2).each{|html|@all_elements << Crowler::parse(html,99)}}
File.open('tags.txt','w+'){|result|result << Crowler::crawl(LIST_URL,1,2).each{|html|Crowler::parse(html,0,99)} }

# ['mechanize','nokogiri','pp','benchmark'].each{|gem|require gem}
# $times = []
# class Crowler
#   def self.crawl(url,min_num,max_num)
#     agent = Mechanize.new
#     # example: agent.set_proxy('hoge.com', 6060, 'email%40example.com', 'password')
#     # agent.set_proxy('', , '', '')
#     agent.set_proxy('FOO.torguardvpnaccess.com', 6060, 'BAR%40gmail.com', 'BAZ')
#     # $times << Benchmark.realtime do
#       @htmls ||= []; (min_num..max_num).map{|id|@htmls << agent.get(url+"#{id}").body}; @htmls
#     # end
#   end

#   def self.parse(html,min_num,max_num)
#     # $times << Benchmark.realtime do
#       @elements ||= []; (min_num..max_num).map{|div_id|@elements << Nokogiri::HTML.parse(html).xpath("//*[@id='casset#{div_id}']/div/div[1]/div/h2/a").text}; @elements
#     # end
#   end
# end
# LIST_URL = "https://suumo.jp/jj/fudousan/ichiran/FR351FC001/?ar=030&bs=041&ta=13&sc=13101&sc=13102&sc=13103&sc=13104&sc=13105&sc=13106&sc=13107&sc=13108&sc=13109&sc=13110&sc=13111&sc=13112&sc=13113&sc=13114&sc=13115&sc=13116&sc=13117&sc=13118&sc=13119&sc=13120&sc=13121&sc=13122&sc=13123&sc=13201&sc=13202&sc=13203&sc=13204&sc=13205&sc=13206&sc=13207&sc=13208&sc=13209&sc=13210&sc=13211&sc=13212&sc=13213&sc=13214&sc=13215&sc=13218&sc=13219&sc=13220&sc=13221&sc=13222&sc=13223&sc=13224&sc=13225&sc=13227&sc=13228&sc=13229&pc=100&pn="
# @all_elements ||= []; File.open('tags.txt','w+'){|result|result << Crowler::crawl(LIST_URL,1,2).each{|html|@all_elements << Crowler::parse(html,0,99)}}
# File.open('tags.txt','w+'){|result|result << @all_elements}

# # puts $times.each{|time|"processing time #{time}s"}
# # time = Benchmark.realtime do
# #   c = Crowlling.new
# #   @html ||= []; (1..333).map{|id|"https://xiita.com/tags?page=#{id}"}.each{|url|@html << c.crawl(url)}
# #   @all_tag ||= []; @html.each{|html|@all_tag << c.parse(html)}
# #   c.make_file(@all_tag)
# # end
































# ['mechanize','nokogiri','pp','benchmark'].each{|gem|require gem}
# $times = []
# class Crowler
#   def self.crawl(url,min_num,max_num)
#     agent = Mechanize.new
#     # agent.set_proxy('', , '', '')
#     agent.set_proxy('hoge.com', 6060, 'email%40example.com', 'password')
#     # $times << Benchmark.realtime do
#       @htmls ||= []; (min_num..max_num).map{|id|@htmls << agent.get(url+"#{id}").body}; @htmls
#     # end
#   end

#   def self.parse(html,min_num,max_num)
#     # $times << Benchmark.realtime do
#       @elements ||= []; (min_num..max_num).map{|div_id|@elements << Nokogiri::HTML.parse(html).xpath("//*[@id='casset#{div_id}']/div/div[1]/div/h2/a").text}; @elements
#     # end
#   end
# end
# LIST_URL = "https://suumo.jp/jj/fudousan/ichiran/FR351FC001/?ar=030&bs=041&ta=13&sc=13101&sc=13102&sc=13103&sc=13104&sc=13105&sc=13106&sc=13107&sc=13108&sc=13109&sc=13110&sc=13111&sc=13112&sc=13113&sc=13114&sc=13115&sc=13116&sc=13117&sc=13118&sc=13119&sc=13120&sc=13121&sc=13122&sc=13123&sc=13201&sc=13202&sc=13203&sc=13204&sc=13205&sc=13206&sc=13207&sc=13208&sc=13209&sc=13210&sc=13211&sc=13212&sc=13213&sc=13214&sc=13215&sc=13218&sc=13219&sc=13220&sc=13221&sc=13222&sc=13223&sc=13224&sc=13225&sc=13227&sc=13228&sc=13229&pc=100&pn="
# @all_elements ||= []; File.open('tags.txt','w+'){|result|result << Crowler::crawl(LIST_URL,1,2).each{|html|@all_elements << Crowler::parse(html,0,99)}}
# File.open('tags.txt','w+'){|result|result << @all_elements}

# puts $times.each{|time|"processing time #{time}s"}
# time = Benchmark.realtime do
#   c = Crowlling.new
#   @html ||= []; (1..333).map{|id|"https://xiita.com/tags?page=#{id}"}.each{|url|@html << c.crawl(url)}
#   @all_tag ||= []; @html.each{|html|@all_tag << c.parse(html)}
#   c.make_file(@all_tag)
# end


