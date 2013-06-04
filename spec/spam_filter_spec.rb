require 'spam_filter'

describe SpamFilter do
  context "Messages processing" do
    it "creates a hashes of word based on the input" do
      spam_filter = SpamFilter.new
      spam_filter.feed_message("Life is great", :good)
      spam_filter.words_hash[["life", :good]].should == 1
      spam_filter.feed_message("Life is great", :bad)
      spam_filter.words_hash[["life", :bad]].should == 1
    end

    it "keeps track of the number of times a word has appeared in messages" do
      spam_filter = SpamFilter.new
      spam_filter.feed_message("Life is great", :good)
      spam_filter.feed_message("Life is great", :good)
      spam_filter.words_hash[["life", :good]].should == 2
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
    spam_filter.probability_hash["viagra"].should == 0.99
  end

  it "checks if a message is a spam or not" do
    spam_filter = SpamFilter.new
    spam_filter.feed_message("Hello , I am resending my previous mail to you, i hope you do get it this time around and understand its content fully. I find it pleasurable to offer you my partnership in business.I am contacting you briefly based on the Investment of Seven Million, Eight Hundred Thousand Dollars. (US 7,800,000:00) in your country, as I presently have a client who is interested in investing in your country. I find it imperative to solicit for a partnership. Hence upon receipt of this letter, I implore you to kindly respond and let me know how possible it is to work with you in mutual partnership under the conditions that: 1. My client's fund is legal cash. 2. My client is willing to invest immediately. 3. My client will pay you a commission of 30% of the investment fund for logistics and protocols. 4. My client desires absolute confidentiality in the handling and management of this brief. I must draw your attention to the fact that I have kept the information's herein this letter stated brief; as I do not know if you will receive this letter and or what your response will be, If you do have the interest and the capability to partner with me under the above stated conditions, I will appreciate your response sent back to me Immediately. I will appreciate that you include a brief profile of your self and your company for me to better appreciate your personality. I look forward to your response and our partnership.Have a nice day. Sincerely Yours, Mr. Dennis P. Ramm Esq. Siam Legal's Director of Client Services.", :bad)
    spam_filter.feed_message('Mr. Sandip Saravanan, Project Officer, Ashoka - Innovators for the Public. Subject- Congratulations on being M4G 2013 Finalist Dear Mr. Sandip, Greetings from Digital Empowerment Foundation and Mobile for Good team! At the outset, we would like to thank you for participating in Mobile for Good 2013 initiative through your project "Infiniti Data Initiative". We are glad to inform you that your project has been selected by the Grand Jury as FINALIST. To take it further we request you to share a few more information about your project as below: · Complete Project Plan for next two years (please fill the attached format and send it back to us) · Two recommendation letters on lette heads from any government, industry, civil society or academic institution head about the magnitude, relevance and impact of the project applied for this competition. The recommended institutions must have credibility of operations. · Any case study published · Any beneficiaries account · Other supporting (if any) We are thankful to you for all the information you have provided earlier that helped us in the award process and as the next step you are requested to cooperate with us and send through the required information before June 15, 2013. Feel free to write or call in case of any further query. Looking forward.', :good)
    spam_filter.calculate_probabilities
    spam_filter.spam?('I hope my e-mail meets you well, I am in need of your assistance My Name is William Bill of the engineering Unit here in Baghdad in Iraq; we have about $20 Million US dollars that we want to move out of the country in two digital boxes. My partners and I need a good partner out there, someone we can trust to receive the funds on our behalf.It is oil money and legal we have made arrangements with a United Nation Courier service that will move the funds out of Iraq as a Family Treasures, The most important thing is; Can We Trust you once the funds get to you?, simply take out 30% as your share and keep the remaining 70% for us.Your own part of this deal is to find a safe place where the funds can be sent to, ours is sending it to you safely also you can view the Link(http://news.bbc.co.uk/2/hi/middle_east/2988455.stm)If you are interested I will furnish you with more details upon receipt of your response and contact details But I can assure you the whole process is simple and we must keep a low profile at all times.Please do contact me in my personal Email (williambill20@hotmail.co.uk)I look forward to your reply and co-operation.').should be_true
  end
end
