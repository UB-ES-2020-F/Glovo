DELETE FROM "Restaurants";
DELETE FROM "Products";
DELETE FROM "Users";

INSERT INTO "Users" ("Name", "Email", "PasswordHash", "PasswordSalt")
VALUES
    ('Test 1', 'test1@glovo.net', null, null);

INSERT INTO "Restaurants" ("Id", "Name", "ImgPath")
VALUES
	(1, 'Kentucky Fried Chicken', 'img/KFC_main.jpg'),
	(2, 'McDonalds', 'img/MD_main.jpg'),
	(3, 'Burger King', 'img/BK_main.jpg'),
	(4, 'Krusty Krab', 'img/KK_main.jpg');

INSERT INTO "Products" ("Id", "Name", "ImgPath", "Description", "Price", "RestaurantId")
VALUES
	(1, 'Chicken bucket', 'img/chicken_bucket.jpg', 'Delicioso cubo de pollo, contiene 16 piezas', 14.00, 1),
	(2, 'Chicken bucket XXL', 'img/chicken_bucket_2.jpg', 'Deliciosisimo cubo de pollo, contiene 40 piezas', 30.00, 1),
	(3, 'Chicken bucket XXXXL', 'img/chicken_bucket_3.jpg', 'Delissssssssiooooosssssso cubo de pollo, contiene 99 piezas', 65.00, 1),
	(4, 'Patatas S', 'img/french_fries_1.jpg', '2 patatas fritas rancias', 2.99, 2),
	(5, 'Patatas M', 'img/french_fries_2.jpg', '3 patatas fritas rancias', 3.99, 2),
	(6, 'Patatas L', 'img/french_fries_3.jpg', '3 patatas fritas no rancias', 4.99, 2),
	(7, 'Hambur Guesa', 'img/burger1.jpg', 'This hamburger will prevent you from starving', 7.95, 3),
	(8, 'Hambur Guesa Guesa', 'img/burger2.jpg', 'This hamburger will prevent you from starving for two days', 7.96, 3),
	(9, 'Hambur Goza', 'img/burger3.jpg', 'This hamburger will prevent you from starving for one week', 8.95, 3),
	(10, 'Kangreburger', 'img/kkburger.jpg', 'Delicious krab burger', 1.00, 4),
	(11, 'Kangrefries', 'img/kkfries.jpg', 'Delicious krab fries', 1.00, 4),
	(12, 'Kangrecola', 'img/kkcola.jpg', 'Delicious krab cola', 1.00, 4);
