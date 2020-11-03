require "./lib/gilded_rose"

describe GildedRose do
	describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
		end
		
		it "does update the quality of the product" do
			#for brie the quaility will always only increase - age always decreases
			Item.new(name = "Aged Brie", sell_in = 2, quality = 0)
			 items= [Item.new(name = "Aged Brie", sell_in = 2, quality = 0)]
			 GildedRose.new(items).update_quality()
				expect(items[0].sell_in).to eq 1
				expect(items[0].quality).to eq 1
		end 
  end
end
