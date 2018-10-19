['mechanize','nokogiri','pp','benchmark'].each{|gem|require gem}

$REGION = 
'au melib.au aus bg bul br ca vanc.ca.west cp chil cr czech den egy fin
 fr frank.gr gre hk hg ice loc2.in ind ire iom isr it jp loc2.jp lv lux
 my mx md nl nz no pa pl por ro ru mos.ru singp loc2.singp saudi sp slk
 za sk swe tw thai turk tun uae uk lon.uk ukr fl.east.usa atl.east.usa
 ny.east.usa chi.central.usa dal.central.usa la.west.usa lv.west.usa
 lv.west.usa sa.west.usa nj.east.usa central.usa west.usa east.usa vn'

set_trace_func lambda{|event, file, line, id, binding, klass|
  return if not event == "line" && file ==  __FILE__
  # p "#{event} at #{klass}:#{id} #{file}:#{line}"
  p "#{event}:#{line} at #{klass}:#{id}"
}

class Crawler
  def self.random_proxies
    $REGION.split(' ').sample.+(".torguardvpnaccess.com")
  end

  def self.init(proxy_domain, port, email, password)
    @agent = Mechanize.new
    @agent.set_proxy(proxy_domain, port, email, password) rescue retry
  end

  def self.crawl(url,min,max)
    begin
    Crawler::init(Crawler::random_proxies,6060,ENV['PROXY_USER'],ENV['PROXY_PASSWORD'])
    # @agent = Mechanize.new
    result = ""
    (min..max).map{|id|result << @agent.get(url+"#{id}").body}
    result
    rescue
      retry
    end
  end

  def self.parse(html,min,max,blocks)
    @result =[]
    {html=>blocks}.each{|html,block|(min..max).map{|num|block.each{|b|@result << b.(num,html)}}}
    @result
  end
end


LIST_URL = "https://anond.hatelabo.jp/?mode=top&page="
min,max = ARGV[0].to_s,(ARGV[0].to_i+1000).to_s
all_html = ""
all_html << Crawler::crawl(LIST_URL,min,max)
File.write('all_html.txt'+ARGV[0].to_s, all_html)


# parallel ruby tmp.rb ::: 1 11 21 31 41

# cat all_html.txt1 all_html.txt11 all_html.txt21 all_html.txt31 all_html.txt41 > all_html.txt




# urls = []
# File.read("./all_html.txt").gsub(/<a href=\"\/(\d{14})\">/){|str|urls << $~.to_a[1]}
# urls.uniq!







# all_html = []
# LIST_URL = "https://anond.hatelabo.jp/?mode=top&page="
# all_html << Crawler::crawl(LIST_URL,1,1)
# pp all_html




# blocks = []
# blocks << ->num,html{Nokogiri::HTML.parse("#{html}").xpath("//*[@id='body']/div[3]/div/div[#{num}]/h3/a[1]").attribute("href").value rescue next}




# def test_method(html,min,max,blocks)
#   (min..max).each{|num|p "//*[@id='example#{num}']"}
#   puts '----------------------------------------------'
#   k_v = {html=>blocks[0]}
#   k_v.each{|html,block|(min..max).map{|num|block.call(num,html)}}
# end
# blocks = []
# blocks << ->num,html{p "//*[@id1='example#{num}'] #{html}"}
# test_method("abc",1,3,blocks)


# コメント行を削除する正規表現　^\s*#.* 