require 'utility'

class SpamFilter
  include Utility
  attr_reader :words_hash, :ham_count, :spam_count, :probability_hash

  def initialize
    @words_hash = Hash.new(0)
    @probability_hash = Hash.new(0.4)
    @ham_count = 1
    @spam_count = 1
  end

  def feed_message(message, spam_status)
    increment_counter(spam_status)
    message.scan(/\w+/) do |i|
        @words_hash[[i.downcase,spam_status]] += 1
    end
  end

  # Calculates probabilities for all of the words in word_hash
  def calculate_probabilities
    @words_hash.keys.each do |word, _|
      @probability_hash[word] = calculate_probability(word)
    end
  end

  # Calculates probability using Baye's therom
  # P(S|W) = P(W|S) * P(S) / P(W)
  # P(W) = P(S) * P(W|S) + P(H) * P(W|H)
  def calculate_probability(word)
    ham_word_frequency = 2 * words_hash[[word,:good]]
    spam_word_frequency = words_hash[[word, :bad]]
    return if ham_word_frequency + spam_word_frequency < 5
    word_probability = min(1.0, spam_word_frequency.to_f / spam_count)
    total_probability = word_probability + min(1.0, ham_word_frequency.to_f / ham_count)
    max(0.1, min(0.99, word_probability/total_probability))
  end

  def spam?(message)
    spamicity(message) > 0.9
  end

  # Returns the combination of all of the interesting words in a message
  def spamicity(message)
    words = message.split(/\W+/).map { |m| m.downcase}
    intersting_words_probability_list = intersting_words(words)
    intersting_words_product = intersting_words_probability_list.inject(:*)
    total_probability = intersting_words_product + intersting_words_probability_list.map { |x| 1 - x }.inject(:*)
    intersting_words_product / total_probability
  end

  # Returns the top 15 interesting words
  # Intersting words meaan words with probability close to either 0.01 or 0.99
  def intersting_words(words)
    words_probability_list = words.map { |word| probability_hash[word] }

    # Sorting based on abs(probability - 0.5) ensures that probability close to 0.01 or 0.99
    # will be at the top of the list, since we're sorting by descending order
    words_probability_list.compact.sort { |a, b| (b - 0.5).abs <=> (a - 0.5).abs }[0..14]
  end

  private

  def increment_counter(status)
    @ham_count += 1 if status == :good
    @spam_count += 1 if status == :bad
  end
end
