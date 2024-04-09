require 'cocos'


meta = read_csv( './pennies/pennies.csv' )
puts "  #{meta.size} meta record(s)"

data = []


ids = (0..99).to_a
ids.each do |id|
    path = "./pennies/hashcheck/#{id}.json"

    next unless File.exist?( path )

    ## get first inscription
    rec = read_json( path )['results'][0]
   
    

    spec = meta[ id ]
    type        = spec['type']
    accessories = (spec['attributes'] || '').split( '/' ).map {|attr| attr.strip }


    attributes = []
    attributes << { 'trait_type' => 'type',
                    'value'      => type }
    accessories.each do |acc|   ## change name to attribute (from accessory)
        attributes << { 'trait_type' => 'attribute',
                        'value'      => acc } 
    end
    attributes <<  { 'trait_type' => 'attribute count',
                     'value' => accessories.size.to_s }  ## number (type) possible?
    attributes <<  { 'trait_type' => 'style',
                     'value' =>  'pennies / cents' }
 
    data << {
               'id' => rec['inscriptionid'],
               'meta' => {
                 'name' => "Punk Penny / Cent \##{id+1}",
                 'attributes' => attributes
                }
            }

end


pp data


write_json( "./pennies/inscriptions.json", data )

puts "bye"

