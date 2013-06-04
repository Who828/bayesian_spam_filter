class SpamFilter
  attr_reader :words_hash, :ham_count, :spam_count

  def initialize
    @words_hash = {}
    @ham_count = 0
    @spam_count = 0
  end

  def message(message, spam_status)
    words = message.split.map { |m| m.to_sym }
    increment_counter(spam_status)
    words.each do |i|
      if @words_hash.key?([i,spam_status])
        @words_hash[[i,spam_status]] += 1
      else
        @words_hash[[i, spam_status]] = 1
      end
    end
  end

  private

  def increment_counter(status)
    @ham_count += 1 if status == :good
    @spam_count += 1 if status == :bad
  end
end
