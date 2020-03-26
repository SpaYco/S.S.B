require 'discordrb'
require_relative './game.rb'
require_relative './sum.rb'
class Bot
  def initialize(token_key)
    @bot = Discordrb::Bot.new token: token_key
  end

  # rubocop:disable Metrics/MethodLength
  def game
    @bot.message(start_with: '!game') do |event|
      all_words = Words.new
      picked_word = nil
      start = false
      event.user.await(:sentence) do |sentence_event|
        sentence_arr = sentence_event.message.content.split(' ')
        if sentence_arr.length < 2
          sentence_event.respond 'please add more than one word'
          false
        else
          sentence_arr.each do |word|
            all_words.add(word)
          end
          sentence_event.respond 'hmmm, lots of words, wait while i pick one'
          sleep 2
          picked_word = sentence_arr[rand(0..(sentence_arr.length - 1))]
          sentence_event.respond 'done!'
          start = true
        end
      end
      event.user.await(:word) do |word_event|
        if start == true
          check(word_event, word_event.message.content, picked_word, all_words)
        else
          false
        end
      end
      event.respond 'Welcome To The Random Word Picker Game'
      event.respond 'Give Me All The Words In One Line'
    end
  end

  def sum
    @bot.message(start_with: '!info') do |event|
      event.respond 'this is a @bot made by SpaYco'
      event.respond 'you can check more work on https://github.com/SpaYco'
    end
  end
  # rubocop:enable Metrics/MethodLength

  def info
    @bot.message(start_with: '!sum') do |event|
      number = Sum.new
      event.user.await(:numbers) do |numbers_event|
        numbers_arr = numbers_event.message.content.split(' ')
        numbers_arr.each do |v|
          number.add(v.to_i)
        end
        numbers_event.respond number.total
      end
      event.respond 'Enter All The Numbers To Sum In One Line'
    end
  end

  def start
    @bot.run
  end

  private

  def check(word_event, word, picked_word, all_words)
    if word == picked_word && all_words.check(word) == true
      word_event.respond 'CONGRATS! You Won The Prize Of.. ummm, 500 fake credits that cannot do anything, YAY!'
    elsif word != picked_word && all_words.check(word) == true
      word_event.respond 'nope, try again :smiley:'
      false
    else
      word_event.respond 'insert a valid response :wink:'
      false
    end
  end
end
