require 'cocos'



recs = []


(0..999).each do |i|
    num = '%03d' % i
    path = "./hashcheck/#{num}.json"
    print "."
    print  i   if i % 1000 == 0

    if File.exist?( path )
      data = read_json( path )
      hash = data['ethscription']['sha']
 
      recs << [data['ethscription']['ethscription_number'].to_s, i.to_s]
    end
end
print "\n"


## sort buy inscribe num
recs = recs.sort {|l,r|  l[0].to_i(10) <=> r[0].to_i(10) }

headers = ['num', 'ref']
File.open( "./mint.csv", "w:utf-8" ) do |f|
   f.write( headers.join( ', '))
   f.write( "\n")
   recs.each do |values|
     f.write( values.join( ', ' ))
     f.write( "\n" )
   end
end


puts "bye"


