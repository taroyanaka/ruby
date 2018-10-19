['mechanize','nokogiri','pp','benchmark'].each{|gem|require gem}
class Crowler
  def self.random_proxies
    # ['au','melib.au','aus','bg','bul','br','ca','vanc.ca.west','cp','chil','cr','czech','den','egy','fin','fr','frank.gr',].sample.+(".torguardvpnaccess.com")
    ['au','melib.au','aus',].sample.+(".torguardvpnaccess.com")
  end

  def self.crawl(url,min_num,max_num)
    agent = Mechanize.new
    #agent.set_proxy('hoge.com', 6060, 'email%40example.com', 'password')
    (min_num..max_num).map{|id|agent.get(url+"#{id}").body}
  end

  def self.parse(html,min_num,max_num)
    (min_num..max_num).map{|num|Nokogiri::HTML.parse(html).xpath("//*[@id='casset#{num}']/div/div[1]/div/h2/a").attribute("href").value}
  end
end
# LIST_URL = "https://suumo.jp/jj/fudousan/ichiran/FR351FC001/?ar=030&bs=041&ta=13&sc=13101&sc=13102&sc=13103&sc=13104&sc=13105&sc=13106&sc=13107&sc=13108&sc=13109&sc=13110&sc=13111&sc=13112&sc=13113&sc=13114&sc=13115&sc=13116&sc=13117&sc=13118&sc=13119&sc=13120&sc=13121&sc=13122&sc=13123&sc=13201&sc=13202&sc=13203&sc=13204&sc=13205&sc=13206&sc=13207&sc=13208&sc=13209&sc=13210&sc=13211&sc=13212&sc=13213&sc=13214&sc=13215&sc=13218&sc=13219&sc=13220&sc=13221&sc=13222&sc=13223&sc=13224&sc=13225&sc=13227&sc=13228&sc=13229&pc=100&pn="
# tokyo 100件
# LIST_URL = "https://suumo.jp/jj/fudousan/ichiran/FR351FC001/?ar=030&bs=041&ta=13&sc=13101&sc=13102&sc=13103&sc=13104&sc=13105&sc=13106&sc=13107&sc=13108&sc=13109&sc=13110&sc=13111&sc=13112&sc=13113&sc=13114&sc=13115&sc=13116&sc=13117&sc=13118&sc=13119&sc=13120&sc=13121&sc=13122&sc=13123&sc=13201&sc=13202&sc=13203&sc=13204&sc=13205&sc=13206&sc=13207&sc=13208&sc=13209&sc=13210&sc=13211&sc=13212&sc=13213&sc=13214&sc=13215&sc=13218&sc=13219&sc=13220&sc=13221&sc=13222&sc=13223&sc=13224&sc=13225&sc=13227&sc=13228&sc=13229&pc=100&pn="







LIST_URL = "https://suumo.jp/jj/fudousan/ichiran/FR351FC001/?ar=030&bs=041&ta=13&sc=13101&sc=13102&sc=13103&sc=13104&sc=13105&sc=13106&sc=13107&sc=13108&sc=13109&sc=13110&sc=13111&sc=13112&sc=13113&sc=13114&sc=13115&sc=13116&sc=13117&sc=13118&sc=13119&sc=13120&sc=13121&sc=13122&sc=13123&sc=13201&sc=13202&sc=13203&sc=13204&sc=13205&sc=13206&sc=13207&sc=13208&sc=13209&sc=13210&sc=13211&sc=13212&sc=13213&sc=13214&sc=13215&sc=13218&sc=13219&sc=13220&sc=13221&sc=13222&sc=13223&sc=13224&sc=13225&sc=13227&sc=13228&sc=13229&pc=100&pn="







# LIST_URL = "https://suumo.jp/jj/fudousan/ichiran/FR351FC001/?ar=030&bs=041&ta=13&sc=13101&sc=13102&sc=13103&sc=13104&sc=13105&sc=13106&sc=13107&sc=13108&sc=13109&sc=13110&sc=13111&sc=13112&sc=13113&sc=13114&sc=13115&sc=13116&sc=13117&sc=13118&sc=13119&sc=13120&sc=13121&sc=13122&sc=13123&sc=13201&sc=13202&sc=13203&sc=13204&sc=13205&sc=13206&sc=13207&sc=13208&sc=13209&sc=13210&sc=13211&sc=13212&sc=13213&sc=13214&sc=13215&sc=13218&sc=13219&sc=13220&sc=13221&sc=13222&sc=13223&sc=13224&sc=13225&sc=13227&sc=13228&sc=13229&pc=100&pn="
time = Benchmark.realtime do
  # pp Crowler::crawl(LIST_URL,1,27)
  File.write('tokyo_stores_url.txt',Crowler::crawl(LIST_URL,1,26).map{|html|Crowler::parse(html,0,99)})
end; puts "processing time #{time}s"

"proxyのタイムアウトエラーを例外処理でリトライ"
"procか何かでxpathを可変長引数で複数受け取って処理"
# a = ->gem{require gem}
# # b = ->gem{puts gem}

# def apply_method(l)
#   ['pp','benchmark','selenium-webdriver'].each{|g|l.call(g)}
# end
# apply_method(a)



# def test_method(min_num,max_num,l)
#   (min_num..max_num).map{|g|l.call(g)}.each{|result|p result}
#   (min_num..max_num).map{|g|yield(g)}.each{|result|p result}
# end
# l = ->div_id{"aaa #{div_id}"}
# test_method(1,10,l)

# ['mechanize','nokogiri','pp','benchmark'].each{|gem|require gem}










# def test_method(min,max,param)
#   (min..max).each{|num|p "//*[@id='example#{num}']"}
#   puts '----------------------------------------------'
#   param.call(min)
# end
# param = ->num{p "//*[@id='example#{num}']"}
# test_method(1,2,param)





# def test_method(num,param)
#   param.call(num)
# end
# # param = ->n{p "//*[@id='example#{num}']"}
# param = ->n{p "aaa"}
# test_method(1,param)



# def test_method(*n)
#   yield(n)
# end
# # test_method(1,2,3){|n|p "//*[@id='example#{num}']"} # => 動かない
# test_method(1,2,3){|n|p n}
# puts '----------------------------------------------'
# test_method(1,2,3){|n|n.each{|num|p "//*[@id='example#{num}']"}}









# def test_method(*n)
#   n.each {|i| yield(i) }
# end
# test_method(1,2,3){|n|p "//*[@id='example#{n}']"}





# def test_method(min,max,param)
#   [min,max].each{|num|p "//*[@id='example#{num}']"}
#   puts '----------------------------------------------'
#   param.call(min)
# end
# param = ->num{p "//*[@id='example#{num}']"}
# test_method(1,2,param)
