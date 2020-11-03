require "./lib/gilded_rose"

describe GildedRose do
	describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
		end
		
		context "Old brie quality update case" do
		it "increases  the quality of Brie the older it gets" do
			#for brie the quaility will always only increase - age always decreases
			 items = [Item.new(name = "Aged Brie", sell_in = 2, quality = 0)]
			 GildedRose.new(items).update_quality
				expect(items[0].sell_in).to eq 1
				expect(items[0].quality).to eq 1
		end 

		it "qeeps quality of Brie the same when its quanitity is 50" do 
			items = [Item.new(name = "Aged Brie", sell_in = 2, quality = 50)]
			GildedRose.new(items).update_quality
			expect(items[0].sell_in).to eq 1
			expect(items[0].quality).to eq 50
		end

		it "qeeps increasing quality even when the product is pass the sell by date" do
			items = [Item.new(name = "Aged Brie", sell_in = 0, quality = 49)]
			GildedRose.new(items).update_quality
			expect(items[0].sell_in).to eq -1
			expect(items[0].quality).to eq 50	
		end
	end 

		context "Backstage passes quality update cases" do
			it "increases the backstage pass only by 3 because it is less than 5 days away from the concert" do
				items = [Item.new(name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 5, quality = 40)]
				#it only goes up by one because the quality cannot be more than 50
				GildedRose.new(items).update_quality
				expect(items[0].sell_in).to eq 4
				expect(items[0].quality).to eq 43
			end

			it "increases the backstage pass only by 1  when sell by date is less than 6 because it goes over the quality of 50" do
			items = [ Item.new(name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 5, quality = 49)]
			GildedRose.new(items).update_quality
			expect(items[0].sell_in).to eq 4
			expect(items[0].quality).to eq 50
		end

			it "increases the backstage pass only by 2 because it is less than 10 days away from the concert" do
				items = [Item.new(name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 10, quality = 40)]
				GildedRose.new(items).update_quality
				expect(items[0].sell_in).to eq 9
				expect(items[0].quality).to eq 42
			end

			it "increases the backstage pass only by  because it is less than 10 days away from the concert" do
				items = [Item.new(name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 10, quality = 49)]
				#it only goes up by one because the quality cannot be more than 50
				GildedRose.new(items).update_quality
				expect(items[0].sell_in).to eq 9
				expect(items[0].quality).to eq 50
			end

		end 
  end
end
