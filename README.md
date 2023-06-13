<h1>Calculate Discount Shop</h1>

*Instructions*

To encourage more sales of cereal boxes, a popular cereal shop decided to offer discounts on multiple purchases.

A box of cereal usually costs anything between $32 and $39.

If, however, you buy two cereal boxes, you get a 5% discount on those two boxes.
If you buy 3 cereal boxes, you get a 10% discount.
If you buy 4 cereal boxes, you get a 20% discount.
If you buy 5 or more, you get a 25% discount.
Note: cereal boxes from the KETO collection should be excluded from the discount offer.

Your mission is to write an API to calculate the price of any conceivable shopping cart (containing cereal boxes from multiple collections), returning the discounted price for each individual item and the final discounted price for the entire cart.some tests using RSpec.

*Dependencies*

* Docker
* Docker-compose

*Build your enviorment*

```
docker-compose build
```

*Create your Data base*

```
docker-compose run web rake db:create db:migrate
```

*Run the project*

```
docker-compose up
```

http://0.0.0.0:3000

*Testing the project*

```
docker-compose run web rake spec PGUSER=postgres RAILS_ENV=test
```
