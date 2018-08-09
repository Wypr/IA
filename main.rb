require 'csv'
load 'perceptron.rb'
load 'history.rb'

weights = []

25.times { |_i| weights.push(rand(-1.0..1.0)) }



dados = []

CSV.parse(File.read('default_of_credit_card_clients.csv')) do |row|
  dados << row
end

dados.shift(2)

creditList = []

dados.each do |line|
  line.shift
  creditList.push(History.new(line))
end

maiorTrained = 0.0
maiorNotTrained = 0.0

menorTrained = 101
menorNotTrained = 101

mediaTrained = 0
mediaNotTrained = 0

qnt = 300

qnt.times do |_x|
  perceptron = Perceptron.new(weights)
  notTrained = []
  trained = []
  creditList.each do |_d|
    if rand(0..2) == 1
      perceptron.train(_d.input, _d.output)
      trained.push(_d)
    else
      notTrained.push(_d)
  end
  end

  acerto = 0.0
  accuracy = 0.0
  media = 0.0

  trained.each do |history|
    accuracy +=1 if history.output == perceptron.compute(history.input)  
  end
  
  acerto = 0.0
  
  notTrained.each do |history|
    acerto += 1 if history.output == perceptron.compute(history.input)
  end
  
  mediaNotTrained += (acerto / notTrained.size) * 100
  mediaTrained += (accuracy / trained.size) * 100

  if(maiorTrained < (accuracy / trained.size) * 100)
    maiorTrained = (accuracy / trained.size) * 100
  end
  if(maiorNotTrained < (acerto / notTrained.size) * 100)
    maiorNotTrained = (acerto / notTrained.size) * 100
  end

  if(menorTrained > (accuracy / trained.size) * 100)
    menorTrained = (accuracy / trained.size) * 100
  end
  if(menorNotTrained > (acerto / notTrained.size) * 100)
    menorNotTrained = (acerto / notTrained.size) * 100
  end
end

mediaNotTrained /= qnt
mediaTrained /= qnt

puts "               Menor      Maior      Média"
puts "Validacao    | #{(100.0-maiorNotTrained).truncate(2).to_f} |   | #{(100.0-menorNotTrained).truncate(2).to_f} |   | #{(100.0-mediaNotTrained).truncate(2).to_f} |   "  
puts "Treinamento  | #{(100.0-maiorTrained).truncate(2).to_f} |   | #{(100.0-menorTrained).truncate(2).to_f} |   | #{(100.0-mediaTrained).truncate(2).to_f} |   " 