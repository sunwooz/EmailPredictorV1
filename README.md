###Email Predictor

This is a program that will allow the user to predict email addresses of a person in a company given that you have the email of another person in the same company.

###How to use

Instantiate the PatternFinder class with your sample dataset and call #parse_data

```ruby
dataset = {
  "John Ferguson" => "john.ferguson@alphasights.com",
  "Damon Aw" => "damon.aw@alphasights.com",
  "Linda Li" => "linda.li@alphasights.com",
  "Larry Page" => "larry.p@google.com",
  "Sergey Brin" => "s.brin@google.com",
  "Steve Jobs" => "s.j@apple.com"
}

pf = PatternFinder.new(dataset)
parsed_data = pf.parse_data
```

Use the parsed_data to instantiate a new EmailPredictor

```
ep = EmailPredictor.new(parsed_data)
```

Call #predict_email with the name of the person and and their workplace domain name as arguments.

```ruby
ep.predict_email("Sunwoo Yang", "google.com") 
#=> ["sunwoo.y@google.com", "s.yang@google.com"]
```
