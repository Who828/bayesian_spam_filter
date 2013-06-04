require 'spam_filter'

describe SpamFilter do
  it "creates a hashes of word based on the input" do
      spam_filter = SpamFilter.new
      spam_filter.message("Life is great", :good)
      spam_filter.words_hash[[:Life, :good]].should == 1
      spam_filter.message("Life is great", :bad)
      spam_filter.words_hash[[:Life, :bad]].should == 1
  end
  
  it "keeps track of the number of times a word has appeared in messages" do
      spam_filter = SpamFilter.new
      spam_filter.message("Life is great", :good)
      spam_filter.message("Life is great", :good)
      spam_filter.words_hash[[:Life, :good]].should == 2
  end
end