require 'cocos'
require 'digest'
require 'datauris'



items = []

nums = (0..999)


nums.each do |num|
   puts "==> #{num}"
   name = "%03d" % num
   blob = read_blob( "./ethscribe/martian#{name}.png" )

   uri = DataUri.build( blob, "image/png" )
   hash = Digest::SHA256.hexdigest( uri )
   puts hash

   ## check if taken - must have hashckeck result
   inscriptionNumber =  if File.exist?( "./hashcheck/#{name}.json" )
                           2024  ## return dummy (not 1) for now 
                        else
                           1
                        end 
  
   items << { id: hash,
              name: "##{num}",
              image: "https://github.com/0xCompute/punks12px.vol2/raw/master/ethscribe/martian#{name}.png",
              inscriptionNumber: inscriptionNumber
            }
end


path = "./docs/items.js"
write_json( path, items )

## hack to add const items = upfront
buf  = "// items.js generated on #{Time.now.utc}\n"
buf += "\n"

buf += " const items = " + read_text( path )
write_text( path, buf )

puts "bye"

