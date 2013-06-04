class SpamFilter
  attr_reader :words_hash, :ham_count, :spam_count, :probability_hash

  def initialize
    @words_hash = {}
    @probability_hash = {}
    @ham_count = 1
    @spam_count = 1
  end

  def feed_message(message, spam_status)
    words = message.split.map { |m| m.downcase.to_sym }
    increment_counter(spam_status)
    words.each do |i|
      if @words_hash.key?([i,spam_status])
        @words_hash[[i,spam_status]] += 1
      else
        @words_hash[[i, spam_status]] = 1
      end
    end
  end

  def calculate_probabilities
    @words_hash.keys.each do |word, _|
      @probability_hash[word] = calculate_probability(word)
    end
  end

  def calculate_probability(word)
    ham_word_frequency = 2 * (words_hash[[word,:good]] || 0)
    spam_word_frequency = words_hash[[word, :bad]] || 0
    return if ham_word_frequency + spam_word_frequency < 5
    word_probability = min(1.0, spam_word_frequency.to_f / spam_count)
    total_probability = word_probability + min(1.0, ham_word_frequency.to_f / ham_count)
    max(0.1, min(0.99, word_probability/total_probability))
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
