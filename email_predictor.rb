class EmailPredictor

  attr_accessor :training_data

  def initialize(training_data)
    @training_data = training_data
  end

end

training_data = {
  "John Ferguson" => "john.ferguson@alphasights.com",
  "Damon Aw" => "damon.aw@alphasights.com",
  "Linda Li" => "linda.li@alphasights.com",
  "Larry Page" => "larry.p@google.com",
  "Sergey Brin" => "s.brin@google.com",
  "Steve Jobs" => "s.j@apple.com"
}

ep = EmailPredictor.new(training_data)












