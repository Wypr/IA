class Perceptron
  LEARNING_RATE = 0.01

  def initialize(weights)
    @weights = weights
  end

  def compute(inputs)
    sum = 0
    inputs.each_with_index { |input, index| sum += input.to_f * @weights[index] }
    sign(sum)
  end

  def train(inputs, desired_output)
    guess = compute(inputs)
    error = desired_output - guess
    @weights.each_with_index do |_item, index|
      @weights[index] += error * LEARNING_RATE * inputs[index].to_f
    end
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

