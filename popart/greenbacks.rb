###
#  to run use:
#    $ ruby popart/greenbacks.rb

require 'pixelart'

##### classics by andy warhol
####  200 One Dollar Bils (10x20)
cols, rows = 10, 20

##
# todo - add option for different background - white? why? why not?
#        add option for classic black frame


id = 0 
num = "%02d" % id
punk = Image.read( "../../ordinalpunks/ordinalpunks.sandbox/dollar/ordzaar/greenback#{num}.png" )


composite = ImageComposite.new( cols, rows, width:  punk.width+4,
                                            height: punk.height+4,
                                           background: '#000000' )

count = cols*rows                                           
count.times do 
    tile = Image.new( punk.width+4, punk.height+4 )
    tile.compose!( punk, 2, 2 )  ## add 2/2 padding
  
    composite << tile
end


composite.save( "./tmp/#{rows*cols}greenbacks#{num}.png" )
composite.zoom(2).save( "./tmp/#{rows*cols}greenbacks#{num}@2x.png" )


puts "bye"
