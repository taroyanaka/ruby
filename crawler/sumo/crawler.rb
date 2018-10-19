['mechanize','nokogiri','pp','benchmark'].each{|gem|require gem}

$REGION = 
'au melib.au aus bg bul br ca vanc.ca.west cp chil cr czech den egy fin
 fr frank.gr gre hk hg ice loc2.in ind ire iom isr it jp loc2.jp lv lux
 my mx md nl nz no pa pl por ro ru mos.ru singp loc2.singp saudi sp slk
 za sk swe tw thai turk tun uae uk lon.uk ukr fl.east.usa atl.east.usa
 ny.east.usa chi.central.usa dal.central.usa la.west.usa lv.west.usa
 lv.west.usa sa.west.usa nj.east.usa central.usa west.usa east.usa vn'

class Crowler
  def self.random_proxies
    $REGION.split(' ').sample.+(".torguardvpnaccess.com")
    # ['au','melib.au','aus',].sample.+(".torguardvpnaccess.com")
  end

  def self.init(proxy_domain, port, email, password)
    puts proxy_domain
    @agent = Mechanize.new; @agent.set_proxy(proxy_domain, port, email, password) rescue retry
  end

  def self.crawl(url,min_num,max_num)
    # (min_num..max_num).map{|id|@agent.get(url+"#{id}").body}
    @agent.get("https://suumo.jp/").body
  end

  def self.parse(html,min_num,max_num)
    (min_num..max_num).map{|num|Nokogiri::HTML.parse(html).xpath("//*[@id='casset#{num}']/div/div[1]/div/h2/a").attribute("href").value rescue next}# rescue 
  end
end

LIST_URL = "https://suumo.jp/jj/fudousan/ichiran/FR351FC001/?ar=030&bs=041&ta=14&sc=14101&sc=14102&sc=14103&sc=14104&sc=14105&sc=14106&sc=14107&sc=14108&sc=14109&sc=14110&sc=14111&sc=14112&sc=14113&sc=14114&sc=14115&sc=14116&sc=14117&sc=14118&sc=14131&sc=14132&sc=14133&sc=14134&sc=14135&sc=14136&sc=14137&sc=14151&sc=14152&sc=14153&sc=14201&sc=14203&sc=14204&sc=14205&sc=14206&sc=14207&sc=14208&sc=14210&sc=14211&sc=14212&sc=14213&sc=14214&sc=14215&sc=14216&sc=14217&sc=14218&sc=14300&sc=14320&sc=14340&sc=14360&sc=14380&pc=100&pn="

time = Benchmark.realtime do
  # example: agent.set_proxy('hoge.com', 6060, 'email%40example.com', 'password')
  # Crowler::init(Crowler::random_proxies, 6060, '%40gmail.com', 'bar')
  # File.write('kanagawa_stores_url.txt',Crowler::crawl(LIST_URL,1,10).map{|html|Crowler::parse(html,0,99)})
 100.times{
  Crowler::init(Crowler::random_proxies, 6060, 'foo%40gmail.com', 'bar')
  Crowler::crawl(LIST_URL,1,10)
 }
end; puts "processing time #{time}s
