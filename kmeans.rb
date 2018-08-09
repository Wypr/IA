require 'csv'
require 'kmeans-clusterer'

data = []
labels = []
matriz = []
label_default = []
# Load data from CSV file into two arrays - one for latitude and longtitude data and one for labels
CSV.foreach('default_of_credit_card_clients.csv') do |row|
  matriz << row
end

matriz.each do |line|
  labels.push(line[0])
  line.shift
  data.push(line.map(&:to_i))
  #  line = line.map(&:to_i)
end

[2, 3, 5].each do |_k|
 
  puts "KMeans - #{_k}"
  kmeans = KMeansClusterer.run _k, data, labels: labels, runs: 5
  kmeans.clusters.each do |cluster|
    # puts "Clusters #{cluster.id}"
    # puts "Center of Cluster: #{cluster.centroid}"
    # puts 'Cities in Cluster: ' + cluster.points.map(&:label).join(',')
    sum = 0
    arraYY = 0
    old = []
    tamanho = 0
    tamanhoPagando = []
    cluster.points.map(&:label).each do |_id|
      5.upto(10).each do |_i|
        arraYY += 1 if matriz[_id.to_i].fetch(_i).to_i === -1
        tamanhoPagando.push(matriz[_id.to_i].fetch(2).to_i)
      end
      old.push(matriz[_id.to_i].fetch(2).to_i)
      sum += 1
    end
    tamanho << sum

    porcentsPay = arraYY/sum #para saber quantos % pagaram em dia, 1 - porcentsPay tiveram algum atraso
    
    old = old.uniq.map{|t| [t.to_i,old.count(t)]}.to_h
    tamanhoPagando = tamanhoPagando.uniq.map{|t| [t.to_i,tamanhoPagando.count(t)]}.to_h

    puts "Cluster #{cluster.id}:\n
    Tamanho: #{sum}:\n
    Taxa de pagadores: #{porcentsPay}\n"
    
    old.each do |k, v|
      puts "Graduado(a): #{ (v*100/sum.to_f).truncate(2)} #{((v*100)/tamanhoPagando.fetch(1).to_f).truncate(2)}" if k == 1 
      puts "Acadêmico(a): #{   (v*100/sum.to_f).truncate(2)} #{((v*100)/tamanhoPagando.fetch(1).to_f).truncate(2)}" if k == 2
      puts "Aluno do Ensino Médio(a): #{  (v*100/sum.to_f).truncate(2)} #{((v*100)/tamanhoPagando.fetch(1).to_f).truncate(2)}" if k == 3
      puts "Outros: #{(v*100/sum.to_f).truncate(2)} #{((v*100)/tamanhoPagando.fetch(1).to_f).truncate(2)}" if k == 4
    end
  end
  puts "\n-----------------------------------------"
end
