require "./lib/gilded_rose"

describe GildedRose do
	describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
		end
		
		it "increases  the quality of Brie the older it gets" do
			#for brie the quaility will always only increase - age always decreases
			 items = [Item.new(name = "Aged Brie", sell_in = 2, quality = 0)]
			 GildedRose.new(items).update_quality
				expect(items[0].sell_in).to eq 1
				expect(items[0].quality).to eq 1
		end 

		context "increases the quality of Backstage passes the closer the concert is" do
			it "increases the backstage pass only by 1 because it goes over the quality of 50" do
			items = [ Item.new(name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 5, quality = 49)]
			#it only goes up by one because the quality cannot be more than 50
			GildedRose.new(items).update_quality
			expect(items[0].sell_in).to eq 4
			expect(items[0].quality).to eq 50
		end
	end 
  end
end
