DELETE FROM "Restaurants";
DELETE FROM "Products";
DELETE FROM "Orders";
DELETE FROM "Users";
DELETE FROM "OrdersProducts";

INSERT INTO "Users" ("Name", "Email", "PasswordHash", "PasswordSalt", "Role")
VALUES
    ('Test 1', 'test1@glovo.net', null, null, 0),
    ('Test 2', 'test2@glovo.net', null, null, 0),
    ('Test 3', 'test3@glovo.net', null, null, 0),
    ('Test 4', 'test4@glovo.net', null, null, 0),
    ('Test 5', 'test5@glovo.net', null, null, 0),
    ('Test 6', 'test6@glovo.net', null, null, 0),
    ('Admin', 'admin@glovo.net', '\xa708693392105b5478942aa4809102841ab167756c6cc3fdb3779b016c5cc7f6138c4bd064d3087dca315af69c0c336315c62ca7faf35369e7b8ffa70793c312', '\x89a36aef137ddd3d91b9f67afe74d9b57cbb5898db54a73640cd56f5c92de9aa8a374dd0b9e5a7054c3b39a38f4bdd552389ae186b4f9b4ce9674c0965cfb6b86bbe372dff7f91406dbce653463693426801d3c4ae93305e7478bf19e40929ffce067b498fd723c3ab8e6d9a3ba3db03027b350a60e2d1a9b2b7c2abd92a0332', 1);

INSERT INTO "Restaurants" ("Name", "ImgPath", "Location_Latitude", "Location_Longitude")
VALUES
	('KFC', 'https://res.cloudinary.com/glovoapp/w_1200,f_auto,q_auto/Stores/kgwyyskpc20x3zoquelm', 20, 10),
	('La Tagliatella', 'https://res.cloudinary.com/glovoapp/w_700,h_360,f_auto,q_auto/Stores/ut78sjpa3zs5sl2gf4wl', 20, 40),
	('UDON', 'https://res.cloudinary.com/glovoapp/w_700,h_360,f_auto,q_auto/Stores/oazhwswiwyaebj7fhw0p', 20, 70),
	('Crep Nova', 'https://res.cloudinary.com/glovoapp/w_700,h_360,f_auto,q_auto/Stores/dnhg7ldzheyqper7s0g4', 40, 10),
	('Subway', 'https://res.cloudinary.com/glovoapp/w_700,h_360,f_auto,q_auto/Stores/ipxtregy0mx3y2fqhclp', 40, 40),
	('Burger King', 'https://res.cloudinary.com/glovoapp/w_700,h_360,f_auto,q_auto/Stores/jor4u1grqkmamnybgjs8', 40, 70),
	('Telepizza', 'https://res.cloudinary.com/glovoapp/w_700,h_360,f_auto,q_auto/Stores/s1ftlo8w1vn9ngbgfvep', 70, 40);


INSERT INTO "Products" ("Name", "ImgPath", "Description", "Price", "RestaurantId", "Category")
VALUES
	/*KFC*/
	('Menu Cheddar Addiction Burger', 'https://res.cloudinary.com/glovoapp/w_680,h_240,c_fit,f_auto,q_auto/Products/1439822073', 'Filete de Pechuga Original, disco de cheddar fundido, bacon, lechuga, mayonesa y pan brioche + 1 complemento + 1 bebida', 9.79, 1, 'Menu'),
	('Súper Menú', 'https://res.cloudinary.com/glovoapp/w_680,h_240,c_fit,f_auto,q_auto/Products/1439822010', 'El principal que quieras + 3 complementos + 1 bebida', 9.99, 1, 'Menu'),
	('Chick&Share 12 Tiras para 2', 'https://res.cloudinary.com/glovoapp/w_680,h_240,c_fit,f_auto,q_auto/Products/1439822055', '12 Tiras de Pechuga + 4 salsas', 13.99, 1, 'Menu para 2'),
	('Menú Bucket 12 Tiras para 2', 'https://res.cloudinary.com/glovoapp/w_680,h_240,c_fit,f_auto,q_auto/Products/1439822019', '12 Tiras de Pechuga + 4 salsas + 2 complementos + 2 bebidas', 17.99, 1, 'Menu para 2'),
	('Menú Super Bucket para 2', 'https://res.cloudinary.com/glovoapp/w_680,h_240,c_fit,f_auto,q_auto/Products/1439822064', '2 Twister Wrap + 9 Tiras de Pechuga + 3 salsas + 2 complementos + 2 bebidas', 19.49, 1, 'Menu para 2'),
	('Menú Burger Bacon BBQ Cheddar', 'https://res.cloudinary.com/glovoapp/w_680,h_240,c_fit,f_auto,q_auto/Products/1439822030', 'Filete de Pechuga Original, bacon, BBQ, cheddar y mayonesa + 1 complemento + 1 bebida', 7.79, 1, 'Menu'),
	('3 Alitas Picantes', 'https://res.cloudinary.com/glovoapp/w_680,h_240,c_fit,f_auto,q_auto/Products/1294940110', '3 Alitas Picantes', 2.99, 1, 'Platos'),
	/*La Tagliatella*/
	('Melanzana e parmigiano', 'https://res.cloudinary.com/glovoapp/w_680,h_240,c_fit,f_auto,q_auto/Products/1437602744', 'Tomate, mozzarella, berenjena, parmigiano reggiano DOP, miel y crema balsámica', 12.65, 2, 'Popular'),
	('Prosciutto cotto', 'https://res.cloudinary.com/glovoapp/w_680,h_240,c_fit,f_auto,q_auto/Products/1437602750', 'Tomate, mozzarella y jamón York', 12.00, 2, 'Popular'),
	('Insalata Tagliatella', 'https://res.cloudinary.com/glovoapp/w_680,h_240,c_fit,f_auto,q_auto/Products/1437976627', 'Variado de lechugas, tomate confitado, nueces y manzana caramelizadas, crujiente de prosciutto di Parma DOP, ricotta y crujiente de grana padano DOP', 13.90, 2, 'Populares'),
	('Cannelloni', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/1437602833', 'Carne de ternera y cerdo, bechamel, salsa napolitana y queso', 14.95, 2, 'Populares'),
	('Carpaccio di vitellone', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/1437976659', 'De ternera, con virutas de parmigiano reggiano DOP', 16.45, 2, 'Especiales'),
	('Pane de la Tagliatella (6 bastoni)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/1437602818', 'Pan tradicional con tomates, aceitunas y cebolla', 3.45, 2, 'Aperitivos'),
	/*UDON*/
	('Chicken thai fingers', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/nefvqsyh6txheaivblwq', 'Bastoncitos de pollo rebozados con salsa thai semipicante', 3.95, 3, 'Populares'),
	('Mix de gyozas (4 uds.)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/acmccqfsyyaustdjftq1', 'Cuatro gyozas variadas (chicken curry, gambas con ajetes, verduras y cerdo)', 5.90, 3, 'Populares'),
	('Karee gyudon', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/fia4f9qmlmpvrtzqe5zk', 'Arroz con curry amarillo thai, ternera confitada, cebolla, zanahoria, dashi y cebolleta tierna', 9.95, 3, 'Populares'),
	('Veggie yakisoba', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/ir40e4rou0tde38wbhno', 'Yakisoba salteados con setas shiitake, berenjena, brócoli, calabacín, espárragos trigueros, zanahoria, pimiento rojo y verde y pak choi, con salsa yakisoba y teriyaki', 8.95, 3, 'Populares'),
	('Corral chicken yaki Udon', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/sslvkpikmeoxkl87otnw', 'Yaki Udon salteados con setas shiitake, zanahoria, calabacín, brotes de soja y pechuga de pollo de corral rebozada con Corn Flakes® crujientes y salsa yakisoba', 11.55, 3, 'Populares'),
	('Nabeyaki Udon', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/i6uxfdztkbb7kbie2hnp', 'Udon con láminas de pollo marinado, tempura de langostino, espinacas, huevo de corral semicocido, setas shiitake y tallos de bambú', 11.45, 3, 'Populares'),
	/*Crep Nova*/
	('Pizza Nova2', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/ce72zxaahjjgxppzj5jr', 'Con tomate, mozzarella, orégano y jamón dulce', 10.25, 4, 'Especiales'),
	('Crep de Nutella', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/xwjabn90zrxbwdrfzaj4', 'Crep de Nutella', 5.25, 4, 'Creps'),
	('Patatas Bravas', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/qrximoye4cjlcevrp7d5', 'Patatas Bravas', 5.25, 4, 'Aperitivos'),
	('Personalise Alitas de pollo', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/hcelgfb9kbgpn2k4wakm', 'Salsa bbq incluida', 3.95, 4, 'Extras'),
	('Crep de jamón ibérico y brie', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/t1dluaxh1uwuevxqe0wo', 'Crep de jamón ibérico y brie', 6.45, 4, 'Creps'),
	('Crep de jamón dulce y emmental', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/rrao06rpwi3zfbajk6bg', 'Crep de jamón dulce y emmental', 5.45, 4, 'Creps'),
	/*Subway*/
	('Menú Pollo Teriyaki (15cm)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/elsismvtaiwy0cwui2oj', 'Tiras de pollo en salsa teriyaki', 8.00, 5, 'Menu'),
	('Menú Pollo Empanado (15cm)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/hlmscdc1sd7wt4kmt8kj', 'Pechuga de pollo rebozada', 8.40, 5, 'Menu'),
	('Menú Subway Melt (15cm)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/hj3wofvmeij1wavyhn9j', 'Pechuga de pavo, jamón y beicon.', 8.00, 5, 'Menu'),
	('Menú Bistec y Queso (15cm)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/iu125jmexcwehpke0sjq', 'Ternera troceada con pimiento y cebolla', 8.00, 5, 'Menu'),
	('Menú Pollo al Curry (15cm)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/hoqfeybhvtm9iutadtp9', 'Tiras de pollo en salsa con sabor a curry y yogur', 8.00, 5, 'Menu'),
	('Menú Jamón (15cm)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/en3fi29dgrbzsnqkkm3o', 'Lonchas de jamón', 7.00, 5, 'Menu'),
	/*Burger King*/
	('Alitas de pollo x4', 'https://gps.burgerkingencasa.es/images/products/Alitas_x4.png', 'Estas alitas de pollo se han ganado su lugar en la carta de BURGER KING. Con un toque picante, este entrante es perfecto para los hambrientos amantes del pollo. El pack es de 4 alitas.', 2.95, 6, 'Menu'),
	('Alitas de pollo x8', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/1420808595', 'Estas alitas de pollo se han ganado su lugar en la carta de BURGER KING. Con un toque picante, este entrante es perfecto para los hambrientos amantes del pollo.', 4.70, 6, 'Menu'),
	('Cubo de Nuggets x24', 'https://gps.burgerkingencasa.es/images/products/1575963714913_600x411px_Bodegones_HOMERIA_CUBO_DIC2019.png', '¿No querías Nuggets? ¡Pues toma un cubo entero! Te traemos 24 bocados del mejor pollo, perfecto para compartir y mojar en nuestras deliciosas salsas. Elige 3 gratis entre Barbacoa, Miel Mostaza o Sour Cream. ¡Pídelo y moja!', 7.95, 6, 'Menu'),
	('Delicias de Pollo x4', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/1447809145', '100% pollo y 100% ternura. Lo que pide tu cuerpo: auténtica pechuga de pollo que te alimente. Y lo que pide tu mente: el placer de degustar algo muy tierno. Una mezcla perfecta. ¡Una delicia total!', 2.95, 6, 'Menu'),
	('Big King', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/1275359836', 'Doble contraste y doble sabor, queso fundido sobre doble de carne jugosa a la parrilla, lechuga, pepinillos y cebolla, bañados en exquisita salsa Big King entre dos panes de sésamo crujiente, ¿se puede pedir más?', 4.50, 6, 'Menu'),
	('Big King XXL', 'https://gps.burgerkingencasa.es/images/products/1576058369410_Big_king_XXL.png', 'Porque siempre se puede pedir más, creemos que esto te dejará satisfecho. Una hamburguesa que da la talla… XXL. Imagina 2 hamburguesas a la parrilla con triple de queso fundido sobre ellas, cebolla en rodajas, lechuga, pepinillos y salsa Big King®.', 6.49, 6, 'Menu'),
	/*Telepizza*/
	('Pizza Barbacoa Xtreme', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/di9eujm0q08kb5c3zhlq', 'Masa con un toque ahumado sabor a Barbacoa. Salsa barbacoa, bacon ahumado, pollo marinado, doble de carne de vacuno, topping de mozzarella y salsa barbacoa para dippear.', 15.95, 7, 'Menu'),
	('Telepizza carbonara', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/vpsb2n0thsfp25opfgjl', 'Doble ración de bacón ahumado, champiñón, salsa carbonara, topping a base de mozzarella y cebolla o extra de topping a base de mozzarella (mediana)', 15.95, 7, 'Menu'),
	('De la huerta', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/dbjduku9tblphebm6jde', 'Tiras de pimiento verde, pimiento rojo asado, champiñón, cebolla, aceitunas negras, salsa de tomate y topping a base de mozzarella (mediana)', 15.95, 7, 'Menu'),
	('Telepizza formaggio', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/zrlreddewdvxcblavh64', 'Mezcla de queso suizo curado, provolone, queso en rulo, salsa carbonara y topping a base de mozzarella (mediana)', 15.95, 7, 'Menu'),
	('Telepizza delicheese', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/jpiovqhhuqzkixlgzrcj', 'Mezcla de 5 quesos (emmental, cheddar, edam, mozzarrella y provolone), salsa de tomate confitado y un toque de orégano (mediana)', 15.95, 7, 'Menu'),
	('Telepizza 4 quesos', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/xqoofhzsoxb92sxejaqs', 'Mezcla de quesos azul, edam, mozzarrella, emmental y salsa de tomate (mediana)', 15.95, 7, 'Menu');

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
