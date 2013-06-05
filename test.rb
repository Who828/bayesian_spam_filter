require 'benchmark'
 
Benchmark.bmbm do |b|
    b.report("split"){ 10000.times{"About Bondsy Engineering: Bondsy is building a first-class engineering team to tackle exciting problems in social networks, and also to discover new ways of using technology. We believe in giving engineers the freedom to be creative. We are passionate about the engineering community and open source community, and we're always looking for ways to contribute. At Bondsy you will help build this team and shape its future. About Bondsy: Bondsy is a graduate of TechStars NYC Spring 2012 class. Investors include Thrive Capital, Betaworks, Chris Dixon, Josh Stylman, Peter Hershberg, Patrick Keane, Jared Hecht and Steve Martocci. Qualifications: You consider yourself to be a senior-level developer Mastery of Ruby, Rails, Git, Redis, PostgreSQL, and Heroku A good communicator Significant production experience Interested in taking ownership of the server-side Comfortable collaborating with technical and semi-technical team members to design and implement RESTful APIs and architecture. Experience creating systems that scale for long-term growth Must be willing to work in a highly fast-paced environment Extra Credit: Experience having worked in a mobile-first company Experience having built a social network".split(//u)} }
      b.report("scan "){ 10000.times{"About Bondsy Engineering: Bondsy is building a first-class engineering team to tackle exciting problems in social networks, and also to discover new ways of using technology. We believe in giving engineers the freedom to be creative. We are passionate about the engineering community and open source community, and we're always looking for ways to contribute. At Bondsy you will help build this team and shape its future. About Bondsy: Bondsy is a graduate of TechStars NYC Spring 2012 class. Investors include Thrive Capital, Betaworks, Chris Dixon, Josh Stylman, Peter Hershberg, Patrick Keane, Jared Hecht and Steve Martocci. Qualifications: You consider yourself to be a senior-level developer Mastery of Ruby, Rails, Git, Redis, PostgreSQL, and Heroku A good communicator Significant production experience Interested in taking ownership of the server-side Comfortable collaborating with technical and semi-technical team members to design and implement RESTful APIs and architecture. Experience creating systems that scale for long-term growth Must be willing to work in a highly fast-paced environment Extra Credit: Experience having worked in a mobile-first company Experience having built a social network".scan(/./u)} }
end
 
