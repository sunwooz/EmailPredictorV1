require_relative './name_splitter'
require_relative './email_pattern'

class PatternFinder
  include NameSplitter

  def initialize(training_data)
    @training_data = training_data
  end

  def parse_data
    parsed_data = training_data.each_with_object({}) do |(name, email), parsed_hash|
      workplace = determine_workplace(email)
      pattern = determine_pattern(name, email)

      parsed_hash[workplace] ||= Set.new
      parsed_hash[workplace] << pattern
    end
    convert_hash_value_to_array(parsed_data)
  end

  private
    attr_reader :training_data

    def convert_hash_value_to_array(parsed_data)
      parsed_data.each_with_object({}) do |(key, set), converted_hash|
        converted_hash[key] = set.to_a
      end
    end

    def determine_workplace(email)
      email.match(/(?:@)([A-Za-z0-9.]+)/)[1]
    end

    def determine_pattern(name, email)
      f_name, l_name = *split_name(name)

      pattern = EmailPattern.all(f_name, l_name).find do |regex, pattern_name|
        check_pattern(pattern_name, regex, email, f_name, l_name)
      end
      pattern[1]
    end

    def check_pattern(pattern_name, regex, email, f_name, l_name)
      pattern_name if matches_pattern?(regex, email)
    end

    def matches_pattern?(regex, email)
      !!email.match(regex)
    end

end