# frozen_string_literal: true

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name == 'Aged Brie' || item.name == 'Backstage passes to a TAFKAL80ETC concert'
        increase_quality
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          increase_quality if item.sell_in < 11
          increase_quality if item.sell_in < 6
        end
      else
        decrease_quality
      end
      update_age
      if item.sell_in.negative?
        if item.name == 'Aged Brie'
          increase_quality
        else
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
            decrease_quality
          else
            erase_quality
          end
        end
      end
    end
  end

  def update_age
    @items.each do |item|
      item.sell_in -= 1 if item.name != 'Sulfuras, Hand of Ragnaros'
    end
  end

  def increase_quality
    @items.each do |item|
      item.quality += 1 if item.quality < 50
    end
  end

  def decrease_quality
    @items.each do |item|
      item.quality -= 1 if item.quality.positive? && item.name != 'Sulfuras, Hand of Ragnaros'
    end
  end

  def erase_quality
    @items.each do |item|
      item.quality -= item.quality
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
