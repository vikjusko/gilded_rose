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

			it "decreases the backstage pass quality to 0 when the concert has passed" do
				items = [Item.new(name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 0, quality = 49)]
				#it only goes up by one because the quality cannot be more than 50
				GildedRose.new(items).update_quality
				expect(items[0].sell_in).to eq -1
				expect(items[0].quality).to eq 0
			end
		end 
		
		context "Ordinary product quality update case" do
			it "decreases the quality of the product" do
				items = [Item.new(name = "Elixir of the Mongoose", sell_in = 5, quality = 7)]
				GildedRose.new(items).update_quality
				expect(items[0].sell_in).to eq 4
				expect(items[0].quality).to eq 6
			end 

			it "decreases the quality by two since the sell by date passed" do
				items = [Item.new(name = "Elixir of the Mongoose", sell_in = 0, quality = 7)]
				GildedRose.new(items).update_quality
				expect(items[0].sell_in).to eq -1
				expect(items[0].quality).to eq 5
			end
		end

		context "Sulfuras, Hand of Ragnaros update quality case" do
			it "keeps the quality and the sell_in date fixed" do
				items = [Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80)]
				GildedRose.new(items).update_quality
				expect(items[0].sell_in).to eq 0
				expect(items[0].quality).to eq 80
			end

			it "keeps the quality and sell_by date the same even though the sell by date has passed" do
				items = [Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = -1, quality = 80)]
				GildedRose.new(items).update_quality
				expect(items[0].sell_in).to eq -1
				expect(items[0].quality).to eq 80
			end
		end

		it "can update the age correctly" do
			items = [Item.new(name = "Sulfuras, Hand of Ragnaros", sell_in = -1, quality = 80)]
			GildedRose.new(items).update_age
			expect(items[0].sell_in).to eq -2
		end 
	end
end


describe Item do 
	let(:item)  { described_class.new(name = '+5 Dexterity Vest', sell_in = 10, quality = 20) }

	it "is initialized with a name" do 
		expect(item.name).to eq "+5 Dexterity Vest"
	end 

	it "is initialized with a sell_in date" do
		expect(item.sell_in).to eq 10
	end

	it "is initalize with a quality" do
		expect(item.quality).to eq 20
	end 

	it "Can return item information as a sentence" do 
		expect(item.to_s).to eq "+5 Dexterity Vest, 10, 20"
	end
end 