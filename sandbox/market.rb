###
# merge all collection editions 

require 'cocos'

data = []


data += read_json( './goldcoins/inscriptions.json' )
data += read_json( './pennies/inscriptions.json' )
data += read_json( './greenbacks/inscriptions.json' )

puts "  #{data.size} inscription record(s)"


write_json( "./tmp/inscriptions.json", data )

puts "bye"
