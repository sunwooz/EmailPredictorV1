require 'ap'
require 'pry'

class EmailPredictor

  attr_reader :training_data

  def initialize(training_data)
    @training_data = parse_data(training_data)
  end

  def predict_email(name, work_domain)
    work_domain = work_domain.downcase
    return "No data availble for #{work_domain}" if !data_available?(work_domain)

    f_name, l_name = *split_name(name)

    possible_emails = []
    @training_data[work_domain].each do |pattern| 
      possible_emails << convert_pattern_to_email(f_name, l_name, pattern, work_domain)
    end

    possible_emails
  end

  private

    def parse_data(training_data)
      parsed_hash = {}

      training_data.each do |name, email|
        workplace = determine_workplace(email)
        pattern = determine_pattern(name, email)

        parsed_hash[workplace] ||= []
        parsed_hash[workplace] << pattern if !parsed_hash[workplace].include?(pattern)
      end

      parsed_hash
    end

    def determine_workplace(email)
      email.match(/(?:@)([A-Za-z0-9.]+)/)[1]
    end

    def determine_pattern(name, email)
      f_name, l_name = *split_name(name)

      pattern ||= check_first_name_dot_last_name(f_name, l_name, email)
      pattern ||= check_first_name_dot_last_initial(f_name, l_name, email)
      pattern ||= check_first_initial_dot_last_name(f_name, l_name, email)
      pattern ||= check_first_initial_dot_last_initial(f_name, l_name, email)
      pattern
    end

    def split_name(name)
      name.downcase.split(" ")
    end

    def check_first_name_dot_last_name(f_name, l_name, email)
      pattern = /#{f_name}.#{l_name}[^@]*/
      "first_name_dot_last_name" if matches_pattern?(pattern, email)
    end

    def check_first_name_dot_last_initial(f_name, l_name, email)
      pattern = /#{f_name}.#{l_name[0]}[^@]*/
      "first_name_dot_last_initial" if matches_pattern?(pattern, email)
    end

    def check_first_initial_dot_last_name(f_name, l_name, email)
      pattern = /#{f_name[0]}.#{l_name}[^@]*/
      "first_initial_dot_last_name" if matches_pattern?(pattern, email)
    end

    def check_first_initial_dot_last_initial(f_name, l_name, email)
      pattern = /#{f_name[0]}.#{l_name[0]}[^@]*/
      "first_initial_dot_last_initial" if matches_pattern?(pattern, email)
    end

    def convert_pattern_to_email(f_name, l_name, pattern, work_domain)
      possible_patterns = {
        fndln: "#{f_name}.#{l_name}@#{work_domain}",
        fndli: "#{f_name}.#{l_name[0]}@#{work_domain}",
        fidln: "#{f_name[0]}.#{l_name}@#{work_domain}",
        fidli: "#{f_name[0]}.#{l_name[0]}@#{work_domain}"
      }

      case pattern
      when "first_name_dot_last_name"
        email = possible_patterns[:fndln]
      when "first_name_dot_last_initial"
        email = possible_patterns[:fndli]
      when "first_initial_dot_last_name"
        email = possible_patterns[:fidln]
      when "first_initial_dot_last_initial"
        email = possible_patterns[:fidli]
      end

      email
    end

    def data_available?(work_place)
      !!@training_data[work_place]
    end

    def matches_pattern?(pattern, email)
      !!email.match(pattern)
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
ap ep.training_data

ap ep.predict_email("Sunwoo Yang", "whatever.com")
ap ep.predict_email("Sunwoo Yang", "Alphasights.com")
ap ep.predict_email("Daniel Ferguson", "google.com")
ap ep.predict_email("George Fesati", "apple.com")
ap ep.predict_email("Peter Wong", "alphasights.com")
ap ep.predict_email("Craig Silverstein", "google.com")
ap ep.predict_email("Steve Wozniak", "apple.com")
ap ep.predict_email("Barack Obama", "whitehouse.gov")










