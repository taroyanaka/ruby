['mechanize','nokogiri','pp','benchmark'].each{|gem|require gem}

class Crowler
  def self.random_proxies
    ['au','melib.au','aus','bg','bul','br','ca','vanc.ca.west','cp','chil','cr','czech','den','egy','fin','fr','frank.gr',].sample.+(".torguardvpnaccess.com")
    # ['au','melib.au','aus',].sample.+(".torguardvpnaccess.com")
  end

  def self.crawl(url,min_num,max_num)
    agent = Mechanize.new
    # example: agent.set_proxy('hoge.com', 6060, 'email%40example.com', 'password')
    # agent.set_proxy(Crowler::random_proxies, 6060, 'foo%40gmail.com', 'bar')
    (min_num..max_num).map{|id|agent.get(url+"#{id}").body}
  end

  def self.parse(html,min_num,max_num)
    (min_num..max_num).map{|num|Nokogiri::HTML.parse(html).xpath("//*[@id='casset#{num}']/div/div[1]/div/h2/a").attribute("href").value rescue next}# rescue 
  end
end
# LIST_URL = "https://suumo.jp/jj/fudousan/ichiran/FR351FC001/?ar=030&bs=041&ta=13&sc=13101&sc=13102&sc=13103&sc=13104&sc=13105&sc=13106&sc=13107&sc=13108&sc=13109&sc=13110&sc=13111&sc=13112&sc=13113&sc=13114&sc=13115&sc=13116&sc=13117&sc=13118&sc=13119&sc=13120&sc=13121&sc=13122&sc=13123&sc=13201&sc=13202&sc=13203&sc=13204&sc=13205&sc=13206&sc=13207&sc=13208&sc=13209&sc=13210&sc=13211&sc=13212&sc=13213&sc=13214&sc=13215&sc=13218&sc=13219&sc=13220&sc=13221&sc=13222&sc=13223&sc=13224&sc=13225&sc=13227&sc=13228&sc=13229&pc=100&pn="
# tokyo 100件
# LIST_URL = "https://suumo.jp/jj/fudousan/ichiran/FR351FC001/?ar=030&bs=041&ta=13&sc=13101&sc=13102&sc=13103&sc=13104&sc=13105&sc=13106&sc=13107&sc=13108&sc=13109&sc=13110&sc=13111&sc=13112&sc=13113&sc=13114&sc=13115&sc=13116&sc=13117&sc=13118&sc=13119&sc=13120&sc=13121&sc=13122&sc=13123&sc=13201&sc=13202&sc=13203&sc=13204&sc=13205&sc=13206&sc=13207&sc=13208&sc=13209&sc=13210&sc=13211&sc=13212&sc=13213&sc=13214&sc=13215&sc=13218&sc=13219&sc=13220&sc=13221&sc=13222&sc=13223&sc=13224&sc=13225&sc=13227&sc=13228&sc=13229&pc=100&pn="

LIST_URL = "https://suumo.jp/jj/fudousan/ichiran/FR351FC001/?ar=030&bs=041&ta=14&sc=14101&sc=14102&sc=14103&sc=14104&sc=14105&sc=14106&sc=14107&sc=14108&sc=14109&sc=14110&sc=14111&sc=14112&sc=14113&sc=14114&sc=14115&sc=14116&sc=14117&sc=14118&sc=14131&sc=14132&sc=14133&sc=14134&sc=14135&sc=14136&sc=14137&sc=14151&sc=14152&sc=14153&sc=14201&sc=14203&sc=14204&sc=14205&sc=14206&sc=14207&sc=14208&sc=14210&sc=14211&sc=14212&sc=14213&sc=14214&sc=14215&sc=14216&sc=14217&sc=14218&sc=14300&sc=14320&sc=14340&sc=14360&sc=14380&pc=100&pn="
# LIST_URL = "https://suumo.jp/jj/fudousan/ichiran/FR351FC001/?ar=030&bs=041&ta=14&sc=14101&sc=14102&sc=14103&sc=14104&sc=14105&sc=14106&sc=14107&sc=14108&sc=14109&sc=14110&sc=14111&sc=14112&sc=14113&sc=14114&sc=14115&sc=14116&sc=14117&sc=14118&sc=14131&sc=14132&sc=14133&sc=14134&sc=14135&sc=14136&sc=14137&sc=14151&sc=14152&sc=14153&sc=14201&sc=14203&sc=14204&sc=14205&sc=14206&sc=14207&sc=14208&sc=14210&sc=14211&sc=14212&sc=14213&sc=14214&sc=14215&sc=14216&sc=14217&sc=14218&sc=14300&sc=14320&sc=14340&sc=14360&sc=14380&pc=100&pn=10"



# LIST_URL = "https://suumo.jp/jj/fudousan/ichiran/FR351FC001/?ar=030&bs=041&ta=13&sc=13101&sc=13102&sc=13103&sc=13104&sc=13105&sc=13106&sc=13107&sc=13108&sc=13109&sc=13110&sc=13111&sc=13112&sc=13113&sc=13114&sc=13115&sc=13116&sc=13117&sc=13118&sc=13119&sc=13120&sc=13121&sc=13122&sc=13123&sc=13201&sc=13202&sc=13203&sc=13204&sc=13205&sc=13206&sc=13207&sc=13208&sc=13209&sc=13210&sc=13211&sc=13212&sc=13213&sc=13214&sc=13215&sc=13218&sc=13219&sc=13220&sc=13221&sc=13222&sc=13223&sc=13224&sc=13225&sc=13227&sc=13228&sc=13229&pc=100&pn="
time = Benchmark.realtime do
  # pp Crowler::crawl(LIST_URL,1,27)
  File.write('kanagawa_stores_last_url.txt',Crowler::crawl(LIST_URL,10,10).map{|html|Crowler::parse(html,0,99)})
end; puts "processing time #{time}s"
