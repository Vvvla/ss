module CommonHelper

  require 'rubygems'
  require 'active_support/core_ext/numeric/time'
  require 'chronic'

  def unique_email(email)
    if email == ""
      return ""
    elsif email.include? "original"
      return email.gsub("original ", "")
    end
    email = email.split('@')
    "#{email.first}#{@random_string}@#{email.last}"
  end

  def unique_value(value)
    if value.include? "original"
        value.gsub("original ", "")
    elsif value == "blank"
        ""
    elsif value == "long"
        "veryLongValue" * 20
    else
        value + @random_string
    end
  end

  def parse_link_from(message, link_text)
    doc = Nokogiri::HTML(message)
    node = doc.search('a').detect { |a| a.text == link_text }
    node['href'] if node
  end

  def convert_time(time, format)
    if time.include? 'today'
      parsed_time = time.split('today')
      if parsed_time.size < 2
        Time.now.strftime(format)
      else
        shift = time.gsub(/\D/, '').to_i.days.to_i
        parsed_time = (time.include? '+') ? Time.now + shift : Time.now - shift
        parsed_time.strftime(format)
      end
    end
  end

  def convert_date(date)
    Chronic.parse(date).strftime('%m/%d/%Y')
  end

  def convert_calendar_date(date)
    Chronic.parse(date).strftime('%A, %B %-d, %Y')
  end
end

