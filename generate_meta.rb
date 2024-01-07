require 'cocos'


##
# read in all meta data records of all 10 000 punks
recs = read_csv( './etc/punks24px.csv' )
puts "#{recs.size} punk(s)"  #=> 10000 punk(s)


def generate_punk( *values  )
  ## remove empty attibutes
  values = values.select { |value| !value.empty? }

  
   alien1 = ['Alien Purple', 'Alien Red']
   alien2 = ['Alien Lime', 'Alien Lime', 'Alien Lime', 'Alien Green']
   alien3 = ['Alien', 'Alien Blue']
   alien4 = ['Alien Magenta']

   punk_type = "" 
   punk_type +=  case values[0]
                 when 'Male 1', 'Female 1'    then alien1[ rand(alien1.size)]
                 when 'Male 2', 'Female 2'    then  alien2[ rand(alien2.size)]
                 when 'Male 3', 'Female 3'    then  alien3[ rand(alien3.size)]
                 else #  'Male 4', 'Female 4', 'Ape', 'Zombie', 'Alien'  
                   alien4[ rand(alien4.size)]
                 end
  punk_type += " Female"   if values[0].downcase.index( 'female' )

  attribute_names = values[1..-1]
 
  punk_type = 'Alien Gold'    if attribute_names.include?( 'Smile' )
  punk_type = 'Alien Orange'  if attribute_names.include?( 'Frown' )
 



  ## move "hidden" earring always last (top on stack) 
  has_earring = false
  attribute_names = attribute_names.select do |attribute_name|
    case attribute_name
    when 'Earring' then  has_earring=true; false
    else true
    end
  end
  attribute_names << 'Earring'    if has_earring



  ## attributes - rm smile, frown
  attribute_names = attribute_names.select do |attribute_name|
                              case attribute_name
                              when 'Smile' then false
                              when 'Frown' then false
                              else true
                              end
                         end


  lipstick    = ['Pink Lipstick', 'Burgundy Lipstick']
  side        = ['Orange Side', 'Orange Side', 'Blonde Side', 'White Side']
  short       = ['Blonde Short', 'Blonde Short', 'Pink Short']
  half_shaved = ['Half Shaved', 'Half Shaved', 'Half Shaved Blonde', 
                 'Half Shaved Purple']
  pigtails    = ['Pigtails', 'Pigtails', 'Pigtails Red', 'Pigtails Blonde']

  attribute_names = attribute_names.map do |attribute_name|
                                        case attribute_name
                                        when 'Small Shades'    then 'Laser Eyes Gold'
                                        when 'Welding Goggles' then 'Laser Eyes Gold'
                                        when 'Black Lipstick'  then  lipstick[ rand( lipstick.size) ]
                                        when 'Orange Side'     then  side[ rand( side.size) ]
                                        when 'Blonde Short'    then  short[ rand( short.size) ]
                                        when 'Half Shaved'  then  half_shaved[ rand( half_shaved.size) ]
                                        when 'Pigtails'  then  pigtails[ rand( pigtails.size) ]
                                        else attribute_name
                                        end
                                     end


  ## eyeshadow not really working for alien eyes
  ##   change to face "blemish"                       
    attribute_names = attribute_names.map do |attribute_name|
        case attribute_name
        when 'Blue Eye Shadow'   then 'Rosy Cheeks'
        when 'Purple Eye Shadow' then 'Spots'
        when 'Green Eye Shadow'  then 'Mole'
        else attribute_name
        end
    end


  [punk_type, *attribute_names]
end # method generate


##
# let's go - generate all using the records

srand( 4242 )   # make deterministic

meta = []
recs[0,1000].each_with_index do |rec,i|
  puts "==> punk #{i}:"
  pp rec

  values = rec.values
  attributes = generate_punk( *values )

  type            = attributes[0]
  more_attributes = attributes[1..-1]

  meta << [i.to_s, type, more_attributes.join( ' / ')]   
end



headers = ['id', 'type', 'attributes']
File.open( "./martians12px.csv", "w:utf-8" ) do |f|
   f.write( headers.join( ', '))
   f.write( "\n")
   meta.each do |values|
     f.write( values.join( ', ' ))
     f.write( "\n" )
   end
end

puts "bye"

