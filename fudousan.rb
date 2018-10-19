require 'mechanize'
require 'nokogiri'
require 'nkf'
require 'pp'
require 'benchmark'
require "csv"
require 'stackprof'


class Test
  # 個別ページの読み込んで @htmmlにして def encoderに渡す
  def crawling_test(url)
    agent = Mechanize.new
    # プロキシ設定
    # agent.set_proxy('プロキシ名', ポート, 'test%40jp.test.com', 'パスワード')
    agent.set_proxy('jp.proxydomain.com', 6060, '', '')
    page = agent.get(url)
    @html = page.body #=> HTML文字列
  end

  # @htmlをEUC-JPからUTF-8にする
  def encoder_html_eucjp_to_utf8
    @html.encode!("UTF-8", "EUC-JP")
  end

  # エンコードされた@htmlから個別の要素を抜き出す
  def parse_test
    @elements = []
    doc = Nokogiri::HTML.parse(@html)

    # 会社名
    @elements << doc.xpath("//*[@id='cont']/div[1]/div/div[2]/div[1]/p").text
    # 会社詳細
    @elements << doc.xpath("//*[@id='cont']/div[1]/div/div[2]/div[2]/p").text
    # 電話番号
    @elements << doc.xpath("//*[@id='cont']/div[1]/div/div[2]/table/tbody/tr/td[1]/p").text
    # 所在地
    @elements << doc.xpath("//*[@id='cont']/table/tbody/tr[2]/td/p").text
    # 交通
    @elements << doc.xpath("//*[@id='cont']/table/tbody/tr[3]/td/p").text
    # 営業時間
    @elements << doc.xpath("//*[@id='cont']/table/tbody/tr[4]/td").text
    # 定休日
    @elements << doc.xpath("//*[@id='cont']/table/tbody/tr[5]/td/p").text
    # 営業可能地域について
    @elements << doc.xpath("//*[@id='cont']/div[2]/table/tbody/tr[1]/td/p").text
    # 取扱物件
    @elements << doc.xpath("//*[@id='cont']/div[2]/table/tbody/tr[2]/td/p").text
    # 免許番号
    @elements << doc.xpath("//*[@id='cont']/div[2]/table/tbody/tr[3]/td/p").text
    # 所属団体
    @elements << doc.xpath("//*[@id='cont']/div[2]/table/tbody/tr[4]/td/p").text
    # 会社HP
    @elements << doc.xpath("//*[@id='cont']/div[2]/table/tbody/tr[5]/td/p/a").text
  end

  def csv_make
    CSV.open('test2.csv','a+') do |test|
      test << @elements
    end
  end

  # ファイルをEUC-JPからUTF-8にする
  def encoder_file_shiftjis_to_utf8
    File.open("./tmp.txt", w).encode!("UTF-8", "Shift_JIS")
  end
end



@count = 0
result = Benchmark.realtime do
  t = Test.new
  File.open("./gids.txt").each do |gid|
    @count += 1
    puts @count
    puts gid
     t.crawling_test("http://www.fudousan.or.jp/system/?act=gd&type=41&gid=#{gid}")
     t.encoder_html_eucjp_to_utf8 rescue next
     t.parse_test
     t.csv_make
  end
end
puts "処理時間 #{result}s"