require 'discordrb'
require './lib/game.rb'

# Insert Your Bot Token Here, Use the README file if you're not sure How
bot = Discordrb::Bot.new token: 'NjkxOTk0Mzc5Nzc4MzkyMTI0.XnoEIQ.oe1dRZoNX-DTV_ZWXhm5CBqAV7o'

bot.message(start_with: '!game') do |event|
  words = Words.new
  picked_word = nil
  event.user.await(:sentence) do |sentence_event|
    sentence_arr = sentence_event.message.content.split(' ')
    sentence_arr.each do |word|
      words.add(word)
    end
    sentence_event.respond 'hmmm, lots of words, wait while i pick one'
    sleep 2
    picked_word = sentence_arr[rand(0..(sentence_arr.length - 1))]
    sentence_event.respond 'done!'
  end
  event.user.await(:word) do |word_event|
    word = word_event.message.content
    if word == picked_word && words.check(word) == true
      word_event.respond 'CONGRATS! You Won The Prize Of.. ummm, 500 fake credits that cannot do anything, YAY!'
    elsif word != picked_word && words.check(word) == true
      word_event.respond 'nope, try again :smiley:'
      false
    else
      word_event.respond 'insert a valid response :wink:'
      false
    end
  end
  event.respond 'Welcome To The Random Word Picker Game'
  sleep 0.5
  event.respond 'Give Me All The Words In One Line'
end

bot.run
