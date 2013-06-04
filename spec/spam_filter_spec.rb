require 'spam_filter'

describe SpamFilter do
  context "Messages processing" do
    it "creates a hashes of word based on the input" do
      spam_filter = SpamFilter.new
      spam_filter.feed_message("Life is great", :good)
      spam_filter.words_hash[[:life, :good]].should == 1
      spam_filter.feed_message("Life is great", :bad)
      spam_filter.words_hash[[:life, :bad]].should == 1
    end

    it "keeps track of the number of times a word has appeared in messages" do
      spam_filter = SpamFilter.new
      spam_filter.feed_message("Life is great", :good)
      spam_filter.feed_message("Life is great", :good)
      spam_filter.words_hash[[:life, :good]].should == 2
    end

    it "keep tracks of total ham and spam mails" do
      spam_filter = SpamFilter.new
      spam_filter.feed_message("Life is great", :bad)
      spam_filter.feed_message("Life is great", :bad)
      spam_filter.feed_message("Life is great", :good)
      spam_filter.spam_count.should == 3
      spam_filter.ham_count.should == 2
    end
  end

  it "calculates the correct probability" do
    spam_filter = SpamFilter.new
    spam_filter.feed_message("Get Viagra here without a prescription", :bad)
    spam_filter.feed_message("Get Viagra here without a prescription", :bad)
    spam_filter.feed_message("Get Viagra here without a prescription", :bad)
    spam_filter.feed_message("Get Viagra here without a prescription", :bad)
    spam_filter.feed_message("Get Viagra here without a prescription", :bad)
    spam_filter.calculate_probabilities
    spam_filter.probability_hash[:viagra].should == 0.99
  end
end
