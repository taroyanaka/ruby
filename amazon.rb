require 'amazon/ecs'
require 'pp'

Amazon::Ecs.options = {
    :associate_tag     => ENV['associate_tag'],
    :AWS_access_key_id => ENV['AWS_access_key_id'],
    :AWS_secret_key    => ENV['AWS_secret_key'],
}
search_word = ARGV[0]
pp Amazon::Ecs.item_search(search_word, {:search_index => 'VideoGames', :response_group => 'ItemAttributes,OfferFull,Reviews', :country => 'jp' })
