class SpamFilter
  attr_reader :words_hash

  def initialize
    @words_hash = {}
  end

  def message(message, spam_status)
    words = message.split.map { |m| m.to_sym }
    words.each do |i|
      if @words_hash.key?([i,spam_status])
        @words_hash[[i,spam_status]] += 1
      else
        @words_hash[[i, spam_status]] = 1
      end
    end
  end
end
