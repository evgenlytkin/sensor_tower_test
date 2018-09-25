class CSV

  def self.parse data, separator = ",", quote = "\""
    final_array = [[]]

    in_quote = false
    in_quote_escape = false
    current_value = ""

    data.each_char do |char|

      if in_quote
        if char == quote
          if in_quote_escape
            current_value += char
            in_quote_escape = false
          else
            in_quote_escape = true
          end
        elsif in_quote_escape
          in_quote = false
          in_quote_escape = false
        else
          current_value += char
        end
      end

      if char == quote
        in_quote = true
      elsif char == separator
        final_array[-1] << current_value
        current_value = ""
      elsif char == "\n"
        final_array[-1] << current_value
        final_array << []
      else
        current_value += char
      end

    end

    final_array
  end

end