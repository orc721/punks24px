require 'pixelart'

## update fam composite via /ethscribe images


recs = read_csv( './mint.csv' )

cols = 10
rows = recs.size / 10
rows +=1  if recs.size / 10 == 0
punks = ImageComposite.new( cols, rows, height: 12, width: 12 )

recs.each do |rec|
    id = rec['ref'].to_i(10)
    num = '%03d' % id
    punks << Image.read( "./ethscribe/martian#{num}.png" )
end

punks.save( "./tmp/mints.png" )
punks.zoom(4).save( "./tmp/mints@4x.png" )


puts "bye"