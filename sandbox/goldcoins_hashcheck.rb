###
#  to run use:
#    $ ruby sandbox/goldcoins_hashcheck.rb


$LOAD_PATH.unshift( "../../ordbase/ordbase/ordinals/lib" )
require 'ordinals'


missing = []


overwrite = false    ## use cached version or overwrite? 


ids = (0..99).to_a
ids.each do |id|
    path = "./goldcoins/hashcheck/#{id}.json"

    if !overwrite && File.exist?( path )
        ## skip; already checked
    else
        ## note: start counting at 0/0
      puts "==> #{id+1}/#{ids.size}..."
      num = "%02d" % id
      blob = read_blob( "../../ordinalpunks/ordinalpunks.sandbox/coins/ordzaar2/goldcoin#{num}.png" )
      hash = Digest::SHA256.hexdigest( blob )

      data = Ordinalsbot.hashcheck( hash )

      puts "  #{data['status']} #{data['count']}"

      if data['status'] != 'ok'
        puts "!! ERROR - expected status ok, got:"
        pp data
        exit 1
      end

           ## note: only write-out - if count greater one!!!
      if data['count'] > 0
           write_json( path, data )    
      else
           missing << id
      end
    end
end


puts "  #{missing.size} missing item(s) found:"
pp missing


puts "bye"