###
#  to run use:
#    $ ruby popart/goldcoins.rb

require 'pixelart'

### 
## thirty are better than one
# cols, rows = 6, 5
## 200 gold coins
cols, rows = 20, 10

##
# todo - add option for different background - white? why? why not?
#        add option for classic black frame


id = 92 
num = "%02d" % id
punk = Image.read( "../../ordinalpunks/ordinalpunks.sandbox/coins/ordzaar2/goldcoin#{num}.png" )


composite = ImageComposite.new( cols, rows, width:  punk.width,
                                            height: punk.height )

count = cols*rows                                           
count.times do 
    composite << punk
end


composite.save( "./tmp/#{rows*cols}goldcoins#{num}.png" )
composite.zoom(2).save( "./tmp/#{rows*cols}goldcoins{num}@2x.png" )


puts "bye"
