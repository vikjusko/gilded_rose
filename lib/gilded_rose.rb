# frozen_string_literal: true

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      # item name is not brie nor is it a backstage pass to , nor is it Sulfuras,
      # the qiality is decreased by -1 as long as its quality is more than zero
      if (item.name != 'Aged Brie') && (item.name != 'Backstage passes to a TAFKAL80ETC concert')
        if item.quality.positive?
          item.quality -= 1 if item.name != 'Sulfuras, Hand of Ragnaros'
        end
      else
        # if it is the Brie, backstage pass pr Sulurass, and the quality is less than < 50
        # item quality increases by +1
        if item.quality < 50
          item.quality += 1
          if item.name == 'Backstage passes to a TAFKAL80ETC concert'
            if item.sell_in < 11
              item.quality += 1 if item.quality < 50
            end
            if item.sell_in < 6
              item.quality += 1 if item.quality < 50
            end
          end
        end
      end
      update_age if item.name != 'Sulfuras, Hand of Ragnaros'
      if item.sell_in.negative?
        if item.name != 'Aged Brie'
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
            if item.quality.positive?
              item.quality -= 1 if item.name != 'Sulfuras, Hand of Ragnaros'
            end
          else
            item.quality -= item.quality
          end
        else
          item.quality += 1 if item.quality < 50
        end
      end
    end
  end

	def update_age
		@items.each  do |item|
			item.sell_in -= 1 
		end 
	end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
