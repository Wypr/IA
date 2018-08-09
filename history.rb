class History
  attr_reader :input, :output
  def initialize(data)
    @input = data
    @output = is_positive?(@input)
  end

  def is_positive?(data)
    pos = 0
    neg = 0
    (5..10).each do |it|
      if data[it].to_i < 0
        pos += 1
      else
        neg += 1
      end
    end
    pos > neg ? 1 : pos == neg ? 0 : -1
  end
  end
