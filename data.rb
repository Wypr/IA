
class Perceptron
   LEARNING_RATE = 0.01

  def initialize(weights)
    @weights = weights
  end

  def compute(inputs)
    sum = 0
    inputs.each_with_index { |input, index| sum += input * @weights[index] }
    sign(sum)
  end

  def train(inputs, desired_output)
    guess = compute(inputs)
    error = desired_output - guess
    @weights.each_with_index {|item, index|
      @weights[index] += error * LEARNING_RATE * inputs[index]}
  end 

  def sign(number)
    if number > 0
      1
    elsif number < 0
      -1
    else
      0
    end
end

end

class Data
    def initialize(data)
      @x = x
      @y = y
      @inputs = [@x, @y]
      @ouput = is_above_line?(@x, @y)
    end   
    def is_above_line?(x, y)
        if y > 2 * x + 3
          1
        elsif y < 2 * x + 3
          -1
        else
          0
        end
    end
end 

# dados = Array.new
#
# CSV.parse(File.read('default_of_credit_card_clients.csv')) do |row|
#     dados << row
# end
#
# dados.shift
