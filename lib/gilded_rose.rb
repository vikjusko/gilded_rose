# frozen_string_literal: true

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        increase_quality
        increase_quality if item.sell_in.negative?
      when 'Backstage passes to a TAFKAL80ETC concert'
        increase_quality
        increase_quality if item.sell_in < 11
        increase_quality if item.sell_in < 6
      else
        decrease_quality
      end
      update_age
      next unless item.sell_in.negative?

      case item.name
      when 'Aged Brie'
        increase_quality
      when 'Backstage passes to a TAFKAL80ETC concert'
        erase_quality
      else
        decrease_quality
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

  def ordinary?
    @name != 'Sulfuras, Hand of Ragnaros' && @name != 'Backstage passes to a TAFKAL80ETC concert' && @name != 'Aged Brie'
  end

  def brie?
    @name == 'Aged Brie'
  end
end
