class CSV
  def self.parse(csv_string_data, separator = ",", quote_symbol = "\"")
    start_quote = false
    result = [[]]
    column_value = ''

    csv_string_data.each_char do |symbol|
      if symbol == quote_symbol
        if start_quote
          column_value += symbol
        end

        start_quote ^= true
        next
      end


      if !start_quote && (symbol == separator || symbol == "\n")
        if column_value[-1] == quote_symbol
          column_value = column_value[0..-2]
        end

        result.last << column_value
        column_value = ''

        if symbol == "\n"
          result << []
        end

        next
      end

      column_value += symbol
    end

    if start_quote
      raise ArgumentError.new('unclosed quote')
    else
      if column_value[-1] == quote_symbol
        column_value = column_value[0..-2]
      end

      result.last << column_value
    end

    result
  end
end
