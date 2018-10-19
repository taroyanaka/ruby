# mecab.rb

# -*- coding: utf-8 -*-

# how to use
# yourMacBook-Pro% ruby mecab.rb 品詞 memo1000_uniq_611.txt
# or
# yourMacBook-Pro% ruby mecab.rb 動詞 memo1000_uniq_611.txt

require 'mecab'
require 'pp'

# mysql query is
# select foo from bar WHERE foo is not null AND the_date BETWEEN '2018-04-01 00:00:00' AND '2018-04-06 00:00:00' ORDER BY RAND() limit 1000;
file = ARGV[1]
# sentence = File.open("./memo1000.txt").read
sentence = File.open("./#{file}").read

# sentence = '明日は明日の風が吹く'

mecab = MeCab::Tagger.new
node = mecab.parseToNode(sentence)
word_array = []

word = ARGV[0] # example 名詞 or 動詞
begin
    node = node.next
    if /^#{word}/ =~ node.feature.force_encoding("UTF-8")
        word_array << node.surface.force_encoding("UTF-8")
    end
end until node.next.feature.include?("BOS/EOS")
 
word_hash = {}
word_array.each do |key|
   word_hash[key] ||= 0
   word_hash[key] += 1
end
# puts word_hash

result = word_hash.sort{|(k1, v1), (k2, v2)| v2 <=> v1 }#.reverse
result.each{|e| pp e }
