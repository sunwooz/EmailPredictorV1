require 'set'
require_relative './name_splitter'

class EmailPredictor
  include NameSplitter

  attr_reader :workplace_email_formats

  def initialize(workplace_email_formats)
    @workplace_email_formats = workplace_email_formats
  end

  def predict_email(name, work_domain)
    work_domain = work_domain.downcase
    return "No data available for #{work_domain}" if !data_available?(work_domain)

    f_name, l_name = *split_name(name)

    workplace_email_formats[work_domain].map do |pattern| 
      convert_pattern_to_email(f_name, l_name, pattern, work_domain)
    end
  end

  private

    def convert_pattern_to_email(f_name, l_name, pattern, work_domain)
      possible_patterns = {
        first_name_dot_last_name: "#{f_name}.#{l_name}@#{work_domain}",
        first_name_dot_last_initial: "#{f_name}.#{l_name[0]}@#{work_domain}",
        first_initial_dot_last_name: "#{f_name[0]}.#{l_name}@#{work_domain}",
        first_initial_dot_last_initial: "#{f_name[0]}.#{l_name[0]}@#{work_domain}"
      }

      case pattern
      when :first_name_dot_last_name
        email = possible_patterns[:first_name_dot_last_name]
      when :first_name_dot_last_initial
        email = possible_patterns[:first_name_dot_last_initial]
      when :first_initial_dot_last_name
        email = possible_patterns[:first_initial_dot_last_name]
      when :first_initial_dot_last_initial
        email = possible_patterns[:first_initial_dot_last_initial]
      end

      email
    end

    def data_available?(work_place)
      !!workplace_email_formats[work_place]
    end

    def matches_pattern?(pattern, email)
      !!email.match(pattern)
    end

end









