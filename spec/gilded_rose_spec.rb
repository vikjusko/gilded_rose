# frozen_string_literal: true

require './lib/gilded_rose'

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_item
      expect(items[0].name).to eq 'foo'
    end
  end

  context 'Old brie quality update case' do
    it 'increases  the quality of Brie the older it gets' do
      # for brie the quaility will always only increase - age always decreases
      items = [Item.new(name = 'Aged Brie', sell_in = 2, quality = 0)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq 1
      expect(items[0].quality).to eq 1
    end

    it 'qeeps quality of Brie the same when its quanitity is 50' do
      items = [Item.new(name = 'Aged Brie', sell_in = 2, quality = 50)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq 1
      expect(items[0].quality).to eq 50
    end

    it 'qeeps increasing quality even when the product is almost past its the sell by date' do
      items = [Item.new(name = 'Aged Brie', sell_in = 0, quality = 49)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq(-1)
      expect(items[0].quality).to eq 50
    end

    it 'qeeps increasing quality even when the product is pass the sell by date' do
      items = [Item.new(name = 'Aged Brie', sell_in = -1, quality = 48)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq(-2)
      expect(items[0].quality).to eq 50
    end

    it 'Updates the Quality of Brie by 2 after its pass its sell by date' do
      items = [Item.new(name = 'Aged Brie', sell_in = -10, quality = 7)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq(-11)
      expect(items[0].quality).to eq 9
    end
  end

  context 'Updating conjured items' do
    it 'Updates the quality by 2 when sell by date is has not passed' do
      items = [Item.new(name = 'Conjured Mana Cake', sell_in = 3, quality = 6)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq(2)
      expect(items[0].quality).to eq(4)
    end

    it 'updates the quality by 4 when sell by date has passed' do
      items = [Item.new(name = 'Conjured Mana Cake', sell_in = -1, quality = 6)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq(-2)
      expect(items[0].quality).to eq(2)
    end

    it 'does not update the quality when quality is zero' do
      items = [Item.new(name = 'Conjured Mana Cake', sell_in = -1, quality = 0)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq(-2)
      expect(items[0].quality).to eq(0)
    end
  end

  context 'Backstage passes quality update cases' do
    it 'increases the backstage pass only by 3 because it is less than 5 days away from the concert' do
      items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 5, quality = 40)]
      # it only goes up by one because the quality cannot be more than 50
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq 4
      expect(items[0].quality).to eq 43
    end

    it 'increases the backstage pass only by 2 because it is less than 10 days away from the concert' do
      items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 6, quality = 40)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq 5
      expect(items[0].quality).to eq 43
    end

    it 'increases the backstage pass only by 1 when sell by date is less than 6 because it goes over the quality of 50' do
      items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 5, quality = 49)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq 4
      expect(items[0].quality).to eq 50
    end

    it 'increases the backstage pass only by 2 because it is less than 10 days away from the concert' do
      items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 10, quality = 40)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq 9
      expect(items[0].quality).to eq 42
    end

    it 'increases the backstage pass only by 1 because it is less than 10 days away from the concert' do
      items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 10, quality = 49)]
      # it only goes up by one because the quality cannot be more than 50
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq 9
      expect(items[0].quality).to eq 50
    end

    it 'decreases the backstage pass quality to 0 when the concert has passed' do
      items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 0, quality = 49)]
      # it only goes up by one because the quality cannot be more than 50
      GildedRose.new(items).update_item
      expect(items[0].quality).to eq 0
      expect(items[0].sell_in).to eq(-1)
    end
  end

  context 'Ordinary product quality update case' do
    it 'decreases the quality of the product' do
      items = [Item.new(name = 'Elixir of the Mongoose', sell_in = 5, quality = 7)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq 4
      expect(items[0].quality).to eq 6
    end

    it 'decreases the quality by 2 since the sell by date is todat' do
      items = [Item.new(name = 'Elixir of the Mongoose', sell_in = 0, quality = 7)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq(-1)
      expect(items[0].quality).to eq 5
    end

    it 'Updates the age of product even if the product sell_in is negative and decreases quality by 2' do
      items = [Item.new(name = 'Elixir of the Mongoose', sell_in = -2, quality = 7)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq(-3)
      expect(items[0].quality).to eq 5
    end
  end

  context 'Sulfuras, Hand of Ragnaros update quality case' do
    it 'keeps the quality and the sell_in date fixed' do
      items = [Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq 0
      expect(items[0].quality).to eq 80
    end

    it 'keeps the quality and sell_by date the same even though the sell by date has passed' do
      items = [Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = -1, quality = 80)]
      GildedRose.new(items).update_item
      expect(items[0].sell_in).to eq(-1)
      expect(items[0].quality).to eq 80
    end
  end

  describe '#update age method' do
    it 'can update the age correctly' do
      # it does not update the age of Sulfuras, Hand of Ragnaros"
      items = [Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = - 1, quality = 80)]
      GildedRose.new(items).update_age
      expect(items[0].sell_in).to eq(-1)
    end

    it 'Updates the age of product as long as the name is not Sulfuras' do
      items = [Item.new(name = 'Elixir of the Mongoose', sell_in = 5, quality = 7)]
      GildedRose.new(items).update_age
      expect(items[0].sell_in).to eq 4
    end
  end

  describe 'increase quality method' do
    ## this test is no longer working as the method of increase has been changed
    # it 'does not increase the quality if the product is not Brie or Backstage passes' do
    #   items = [Item.new(name = 'Elixir of the Mongoose', sell_in = 5, quality = 7)]
    #   GildedRose.new(items).increase_quality
    #   expect(items[0].quality).to eq 7
    # end

    it 'does increase the quality of Brie' do
      items = [Item.new(name = 'Aged Brie', sell_in = 0, quality = 49)]
      GildedRose.new(items).increase_quality
      expect(items[0].quality).to eq 50
    end

    it 'Does not increase the quality of a product if the quality is over 50' do
      items = [Item.new(name = 'Aged Brie', sell_in = 0, quality = 50)]
      GildedRose.new(items).increase_quality
      expect(items[0].quality).to eq 50
    end

    it 'does increase the quality of Backstage passes' do
      items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 12, quality = 40)]
      GildedRose.new(items).increase_quality
      expect(items[0].quality).to eq 41
    end
  end

  describe '#decrease quality method' do
    it 'decreases the quality by one' do
      items = [Item.new(name = 'Elixir of the Mongoose', sell_in = 5, quality = 7)]
      GildedRose.new(items).decrease_quality
      expect(items[0].quality).to eq 6
    end

    it 'does not decrease the quality of Sulfuras product' do
      items = [Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = -1, quality = 80)]
      GildedRose.new(items).decrease_quality
      expect(items[0].quality).to eq(80)
    end

    it 'decreases the quality of Conjured items by 2 ' do
      items = [Item.new(name = 'Conjured Mana Cake', sell_in = 3, quality = 6)]
      GildedRose.new(items).decrease_quality
      expect(items[0].quality).to eq 4
    end
  end

  describe '#erase quality' do
    it 'erases the quality for the backstage passes that are past their due date' do
      items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = -1, quality = 40)]
      GildedRose.new(items).erase_quality
      expect(items[0].quality).to eq 0
    end
  end
end

describe Item do
  let(:item) { described_class.new(name = '+5 Dexterity Vest', sell_in = 10, quality = 20) }
  # State testing that is not necessary anymore
  # it 'is initialized with a name' do
  #   expect(item.name).to eq '+5 Dexterity Vest'
  # end

  # it 'is initialized with a sell_in date' do
  #   expect(item.sell_in).to eq 10
  # end

  # it 'is initalize with a quality' do
  #   expect(item.quality).to eq 20
  # end

  it 'Can return item information as a sentence' do
    expect(item.to_s).to eq '+5 Dexterity Vest, 10, 20'
  end
end
