### Planning

1. First step of tackling this KATA is understanding how it works and what the nested if statements mean.
2. Start testing for the easiest cases of always increasing in quality /etc to see where you can refactor and make changes
3. Pulling out new methods that are within the update quality method : 
- Update age method - always decreases age by one, unless the product is 'Sulfuras, Hand of Ragnaros'
- Increase the quality of the product as long as the quality is less than < 50, however if the name is 'Sulfuras, Hand of Ragnaros' - quality can go up higher
- Decrease the quality - quality goes down by one as long as the quality is not negative, however if the product is 'Sulfuras, Hand of Ragnaros' the quality does not go down
4. Refactoring the main code:
-Reversing the if statement to start with positives- if name == Brie and name == Backstage passes, then the quality increases
- the age will always decrease, unless the name is Sulfuras, hand of Ranaros
- Brie will always only increase in its quality- no matter what
- Can now potentially create a method update - that calls two methods inside it : - updating age and updating quality


 