require_relative '../model/email_predictor'
require_relative '../model/pattern_finder'

training_data = {
  "John Ferguson" => "john.ferguson@alphasights.com",
  "Damon Aw" => "damon.aw@alphasights.com",
  "Linda Li" => "linda.li@alphasights.com",
  "Larry Page" => "larry.p@google.com",
  "Sergey Brin" => "s.brin@google.com",
  "Steve Jobs" => "s.j@apple.com"
}

pf = PatternFinder.new(training_data)
work_key_format_value_hash = pf.parse_data
ep = EmailPredictor.new(work_key_format_value_hash)

puts ep.predict_email("Sun Woo Yang", "alphaSights.com")
puts ep.predict_email("Sunwoo Yang", "whatever.com")
puts ep.predict_email("Sunwoo Yang", "Alphasights.com")
puts ep.predict_email("Daniel Ferguson", "google.com")
puts ep.predict_email("George Fesati", "apple.com")
puts ep.predict_email("Peter Wong", "alphasights.com")
puts ep.predict_email("Craig Silverstein", "google.com")
puts ep.predict_email("Steve Wozniak", "apple.com")
puts ep.predict_email("Barack Obama", "whitehouse.gov")

