require 'digest'
require 'datauris'


$LOAD_PATH.unshift( "../pixelart/cryptopunks/punks/lib" )
require 'punks'



specs = read_csv( "./martians12px.csv" )


cols = 50
rows = specs.size / cols 
rows += 1    if specs.size % cols != 0

composite = ImageComposite.new( cols, rows, 
                                  width: 12, height: 12 )


composite2 = ImageComposite.new( 10, 10, 
                                  width: 12, height: 12 )

## double check for uniques                                 
uniques = {}

specs.each_with_index do |rec, i|
     base        = rec['type']
     attributes = (rec['attributes'] || '' ).split( '/').map { |attr| attr.strip }
     
     spec = [base] + attributes

     img = Punk12::Image.generate( *spec )
      
     num = "%03d" % i
     puts "==> martian #{num}"
     img.save( "./ethscribe/martian#{num}.png" )
     img.zoom(8).save( "./tmp/@8x/martian#{num}@8x.png" )
     
     composite << img
     composite2 << img   if i < 100


     blob = read_blob( "./ethscribe/martian#{num}.png" )
     uri = DataUri.build( blob, "image/png" )
     hash = Digest::SHA256.hexdigest( uri )

     uniques[ hash ] ||= [] 
     uniques[ hash ] << i
 
     if uniques[ hash ].size != 1
        puts
        puts "!! duplicate hash; sorry"
        pp  uniques[ hash ]
     end
end


composite.save( "./martians12px.png" )
composite.zoom(2).save( "./tmp/martians12px@2x.png" )

composite2.save( "./tmp/martians12px_100.png" )
composite2.zoom(4).save( "./tmp/martians12px_100@4x.png" )


puts "   duplicates:"
uniques.each do |hash, nums|
    if nums.size > 1
        pp nums
    end
end

puts "bye"

