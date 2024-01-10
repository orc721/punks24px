##
## for a sample
## see https://api.ethscriptions.com/api/collections/sample


require 'cocos'


meta = read_csv( './martians12px.csv' )
puts "  #{meta.size} meta record(s)"


collection_items = []

(0..999).each do |i|
    num = '%03d' % i
    path = "./hashcheck/#{num}.json"

    if File.exist?( path )
       data = read_json( path )

       spec = meta[ i ]
       type       = spec['type']
       attributes = (spec['attributes'] || '').split( '/' ).map {|attr| attr.strip }
    
       item_attributes = []
       item_attributes << { 'trait_type' => 'type',
                            'value'      => type }
       attributes.each do |attr|   ## change name to attribute (from accessory)
           item_attributes << { 'trait_type' => 'attribute',
                                'value'      => attr } 
       end

       item_attributes <<  { 'trait_type' => 'attribute count',
                             'value' => attributes.size.to_s }  ## number (type) possible?
   
       collection_items << {
                  'ethscription_id' => data['ethscription']['transaction_hash'],
                  'name' => "Martian \##{i}",
                  'description' => '',
                  'external_url' => '',
                  'background_color' => '',
                  'item_index' => i,
                  'item_attributes' => item_attributes
               }
    end
end


##
# sample banner is 1400x350px
#  ethscribe color is #C3FF00

collection = {
  'name': 'martians12px',
  'description': 'punks 12px vol. 2 - alien invasion, the martians - first-is-first',
  'total_supply': '1000',
  'logo_image_uri': 'esc://ethscriptions/0x4d932144b83521e5856ca830eb911658a7a846edb13965f111c9b8b470e3de75/data',
  'banner_image_uri': 'https://github.com/0xCompute/punks12px.vol2/raw/master/i/martians12px-banner.png',
  'background_color': '',
  'twitter_link': '',
  'website_link': 'https://github.com/0xCompute/punks12px.vol2',
  'discord_link': 'https://discord.gg/3JRnDUap6y',
  'collection_items' => collection_items
}

write_json( "./martians12px.json", collection )

puts "bye"
