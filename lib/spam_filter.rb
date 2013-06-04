class SpamFilter
  attr_reader :words_hash, :ham_count, :spam_count, :probability_hash

  def initialize
    @words_hash = Hash.new(0)
    @probability_hash = Hash.new(4)
    @ham_count = 1
    @spam_count = 1
  end

  def feed_message(message, spam_status)
    increment_counter(spam_status)
    words = message.scan(/\w+/) do |i|
        @words_hash[[i.downcase,spam_status]] += 1
    end
  end

  def calculate_probabilities
    @words_hash.keys.each do |word, _|
      @probability_hash[word] = calculate_probability(word)
    end
  end

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

  def spamicity(message)
    words = message.split(/\W+/).map { |m| m.downcase}
    probs = intersting_words(words)
    prods = probs.inject(:*)
    prods / (prods + probs.map { |x| 1 - x }.inject(:*))
  end

  def intersting_words(words)
    probs = words.map { |word| probability_hash[word] }
    probs.compact.sort { |a, b| (b - 0.5).abs <=> (a - 0.5).abs }[0..14]
  end

  private

  def increment_counter(status)
    @ham_count += 1 if status == :good
    @spam_count += 1 if status == :bad
  end

  def min(a, b)
    return a if a < b
    return b
  end

  def max(a, b)
    return a if a > b
    return b
  end

end
