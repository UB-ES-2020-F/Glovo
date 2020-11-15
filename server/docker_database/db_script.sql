DELETE FROM "Restaurants";
DELETE FROM "Products";
DELETE FROM "Orders";
DELETE FROM "Users";
DELETE FROM "OrdersProducts";

INSERT INTO "Users" ("Name", "Email", "PasswordHash", "PasswordSalt")
VALUES
    ('Test 1', 'test1@glovo.net', null, null),
    ('Test 2', 'test2@glovo.net', null, null),
    ('Test 3', 'test3@glovo.net', null, null),
    ('Test 4', 'test4@glovo.net', null, null),
    ('Test 5', 'test5@glovo.net', null, null),
    ('Test 6', 'test6@glovo.net', null, null);

INSERT INTO "Restaurants" ("Name", "ImgPath")
VALUES
	('Kentucky Fried Chicken', 'https://franchisopedia.com/public/files/richeditor/publications/KFC_franchise.jpg'),
	('McDonalds', 'https://i.insider.com/52603e346bb3f7d610aaec3b?width=1100&format=jpeg&auto=webp'),
	('Burger King', 'https://www.nevada.shopping/sites/nevada.shopping/files/styles/large/public/field/image/burger-king.jpg?itok=HGieOWOh'),
	('Krusty Krab', 'https://steamuserimages-a.akamaihd.net/ugc/985611310397269750/AA8436B78625BB1AE9FA7530228BC9A073541667/?imw=637&imh=358&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=true');


INSERT INTO "Products" ("Name", "ImgPath", "Description", "Price", "RestaurantId")
VALUES
	('Chicken bucket', 'img/chicken_bucket.jpg', 'Delicioso cubo de pollo, contiene 16 piezas', 14.00, 1),
	('Chicken bucket XXL', 'img/chicken_bucket_2.jpg', 'Deliciosisimo cubo de pollo, contiene 40 piezas', 30.00, 1),
	('Chicken bucket XXXXL', 'img/chicken_bucket_3.jpg', 'Delissssssssiooooosssssso cubo de pollo, contiene 99 piezas', 65.00, 1),
	('Patatas S', 'img/french_fries_1.jpg', '2 patatas fritas rancias', 2.99, 2),
	('Patatas M', 'img/french_fries_2.jpg', '3 patatas fritas rancias', 3.99, 2),
	('Patatas L', 'img/french_fries_3.jpg', '3 patatas fritas no rancias', 4.99, 2),
	('Hambur Guesa', 'img/burger1.jpg', 'This hamburger will prevent you from starving', 7.95, 3),
	('Hambur Guesa Guesa', 'img/burger2.jpg', 'This hamburger will prevent you from starving for two days', 7.96, 3),
	('Hambur Goza', 'img/burger3.jpg', 'This hamburger will prevent you from starving for one week', 8.95, 3),
	('Kangreburger', 'img/kkburger.jpg', 'Delicious krab burger', 1.00, 4),
	('Kangrefries', 'img/kkfries.jpg', 'Delicious krab fries', 1.00, 4),
	('Kangrecola', 'img/kkcola.jpg', 'Delicious krab cola', 1.00, 4);

INSERT INTO "Orders" ("BuyDateTime", "UserId", "RestaurantId")
VALUES
	(TIMESTAMP '2020-10-01 22:23:37', 1, 1),
	(TIMESTAMP '2020-10-04 14:20:28', 1, 4),
	(TIMESTAMP '2020-10-07 15:15:19', 1, 3),
	(TIMESTAMP '2020-10-11 21:55:10', 2, 1),
	(TIMESTAMP '2020-10-15 12:11:51', 3, 1),
	(TIMESTAMP '2020-10-19 14:34:42', 4, 1),
	(TIMESTAMP '2020-10-23 21:14:33', 4, 4),
	(TIMESTAMP' 2020-10-30 23:35:24', 5, 1);

INSERT INTO "OrdersProducts" ("OrderId", "ProductId", "Quantity")
VALUES
	(1, 3, 1),
	(2, 10, 1),
	(2, 11, 1),
	(2, 12, 1),
	(3, 9, 4),
	(4, 3, 10),
	(5, 2, 1),
	(6, 2, 1),
	(7, 10, 3),
	(7, 11, 3),
	(7, 12, 3),
	(8, 1, 1);
