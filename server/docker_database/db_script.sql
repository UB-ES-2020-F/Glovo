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
	('KFC', 'https://res.cloudinary.com/glovoapp/w_1200,f_auto,q_auto/Stores/kgwyyskpc20x3zoquelm', 41.417089, 2.117074),
	('La Tagliatella', 'https://res.cloudinary.com/glovoapp/w_700,h_360,f_auto,q_auto/Stores/ut78sjpa3zs5sl2gf4wl', 41.4339869, 2.149056609),
	('UDON', 'https://res.cloudinary.com/glovoapp/w_700,h_360,f_auto,q_auto/Stores/oazhwswiwyaebj7fhw0p', 41.41008234, 2.15464194),
	('Crep Nova', 'https://res.cloudinary.com/glovoapp/w_700,h_360,f_auto,q_auto/Stores/dnhg7ldzheyqper7s0g4', 41.3728444, 2.162879291),
	('Subway', 'https://res.cloudinary.com/glovoapp/w_700,h_360,f_auto,q_auto/Stores/ipxtregy0mx3y2fqhclp', 41.4341789, 2.125501148),
	('Burger King', 'https://res.cloudinary.com/glovoapp/w_700,h_360,f_auto,q_auto/Stores/jor4u1grqkmamnybgjs8', 41.37041102, 2.19403605),
	('Telepizza', 'https://res.cloudinary.com/glovoapp/w_700,h_360,f_auto,q_auto/Stores/s1ftlo8w1vn9ngbgfvep', 41.40547484, 2.172700424),
	('Domino''s Pizza', 'https://res.cloudinary.com/glovoapp/w_700,h_360,c_fill,f_auto,q_auto/Stores/juyycvvd4t3sjusrmldz', 41.40647484, 2.172700424),
	('TGB', 'https://res.cloudinary.com/glovoapp/w_1200,f_auto,q_auto/Stores/nswcyagsr8fvqphftfok', 41.40547484, 2.173700424),
	('Pans & Company', 'https://res.cloudinary.com/glovoapp/w_1200,f_auto,q_auto/Stores/cdgu2t5wf1gxvqgpoo76', 41.40537484, 2.172700424),
	('La Taquería', 'https://res.cloudinary.com/glovoapp/w_1200,f_auto,q_auto/Stores/zfw7tqt3vil11izlkztq', 41.39547484, 2.152700424),
	('Rostisseria Los Pollos', 'https://res.cloudinary.com/glovoapp/w_1200,f_auto,q_auto/Stores/eg1o9mfi7tuwc7lf6ydk', 41.42547484, 2.172700524),
	('Foster''s Hollywood', 'https://res.cloudinary.com/glovoapp/w_1200,f_auto,q_auto/Stores/gco0kp2pwsdmskz5ermk', 41.381547484, 2.172700424),
	('Santa Burg', 'https://res.cloudinary.com/glovoapp/w_1200,f_auto,q_auto/Stores/a4otfinqfxmyh5rdstej', 41.381547484, 2.132700424);


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
	('Melanzana e parmigiano', 'https://res.cloudinary.com/glovoapp/w_680,h_240,c_fit,f_auto,q_auto/Products/1437602744', 'Tomate, mozzarella, berenjena, parmigiano reggiano DOP, miel y crema balsámica', 12.65, 2, 'Populares'),
	('Prosciutto cotto', 'https://res.cloudinary.com/glovoapp/w_680,h_240,c_fit,f_auto,q_auto/Products/1437602750', 'Tomate, mozzarella y jamón York', 12.00, 2, 'Populares'),
	('Insalata Tagliatella', 'https://res.cloudinary.com/glovoapp/w_680,h_240,c_fit,f_auto,q_auto/Products/1437976627', 'Variado de lechugas, tomate confitado, nueces y manzana caramelizadas, crujiente de prosciutto di Parma DOP, ricotta y crujiente de grana padano DOP', 13.90, 2, 'Populares'),
	('Cannelloni', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/1437602833', 'Carne de ternera y cerdo, bechamel, salsa napolitana y queso', 14.95, 2, 'Populares'),
	('Carpaccio di vitellone', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/1437976659', 'De ternera, con virutas de parmigiano reggiano DOP', 16.45, 2, 'Especiales'),
	('Pane de la Tagliatella (6 bastoni)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/1437602818', 'Pan tradicional con tomates, aceitunas y cebolla', 3.45, 2, 'Aperitivos'),
	/*UDON*/
	('Chicken thai fingers', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/nefvqsyh6txheaivblwq', 'Bastoncitos de pollo rebozados con salsa thai semipicante', 3.95, 3, 'Aperitivos'),
	('Mix de gyozas (4 uds.)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/acmccqfsyyaustdjftq1', 'Cuatro gyozas variadas (chicken curry, gambas con ajetes, verduras y cerdo)', 5.90, 3, 'Aperitivos'),
	('Karee gyudon', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/fia4f9qmlmpvrtzqe5zk', 'Arroz con curry amarillo thai, ternera confitada, cebolla, zanahoria, dashi y cebolleta tierna', 9.95, 3, 'Populares'),
	('Veggie yakisoba', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/ir40e4rou0tde38wbhno', 'Yakisoba salteados con setas shiitake, berenjena, brócoli, calabacín, espárragos trigueros, zanahoria, pimiento rojo y verde y pak choi, con salsa yakisoba y teriyaki', 8.95, 3, 'Populares'),
	('Corral chicken yaki Udon', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/sslvkpikmeoxkl87otnw', 'Yaki Udon salteados con setas shiitake, zanahoria, calabacín, brotes de soja y pechuga de pollo de corral rebozada con Corn Flakes® crujientes y salsa yakisoba', 11.55, 3, 'Populares'),
	('Nabeyaki Udon', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/i6uxfdztkbb7kbie2hnp', 'Udon con láminas de pollo marinado, tempura de langostino, espinacas, huevo de corral semicocido, setas shiitake y tallos de bambú', 11.45, 3, 'Populares'),
	/*Crep Nova*/
	('Pizza Nova2', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/ce72zxaahjjgxppzj5jr', 'Con tomate, mozzarella, orégano y jamón dulce', 10.25, 4, 'Especiales'),
	('Crep de Nutella', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/xwjabn90zrxbwdrfzaj4', 'Crep de Nutella', 5.25, 4, 'Creps'),
	('Patatas Bravas', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/qrximoye4cjlcevrp7d5', 'Patatas Bravas', 5.25, 4, 'Aperitivos'),
	('Alitas de pollo', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/hcelgfb9kbgpn2k4wakm', 'Salsa bbq incluida', 3.95, 4, 'Extras'),
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
	('Alitas de pollo x4', 'https://gps.burgerkingencasa.es/images/products/Alitas_x4.png', 'Estas alitas de pollo se han ganado su lugar en la carta de BURGER KING. Con un toque picante, este entrante es perfecto para los hambrientos amantes del pollo. El pack es de 4 alitas.', 2.95, 6, 'Aperitivos'),
	('Alitas de pollo x8', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/1420808595', 'Estas alitas de pollo se han ganado su lugar en la carta de BURGER KING. Con un toque picante, este entrante es perfecto para los hambrientos amantes del pollo.', 4.70, 6, 'Aperitivos'),
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
	('Telepizza 4 quesos', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/xqoofhzsoxb92sxejaqs', 'Mezcla de quesos azul, edam, mozzarrella, emmental y salsa de tomate (mediana)', 15.95, 7, 'Menu'),
	/*Domino's Pizza*/
	('Pizza Mediana + 2 bebidas + cookies', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/pxizt7gmzvrfe3vfeypz', 'Escoge tu mediana especialidad favorita + 2 uds de cookies + 2 bebidas.', 18.95, 8, 'Top ventas'),
	('Pizza Mediana + 2 bebidas + patatas', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/dzvc0pucqjdrav4x9ufy', 'Escoge tu mediana especialidad favorita + patatas + 2 bebidas.', 18.95, 8, 'Top ventas'),
	('Combo 4 personas', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/jjwsnv3zbgivifwq9mg0', '2 pizzas medianas + complemento a elegir + cookies + 4 latas de refresco.', 28.00, 8, 'Top ventas'),
	('Pizza Mediana - Tony Pepperoni', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/k5hpf12qc71bl9z14rx7', 'Salsa de tomate, extra de queso 100% mozzarella y doble de pepperoni.', 14.45, 8, 'Top ventas'),
	('Chococheese', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/hzxlm2pl8m8nohzxsggs', 'Cremoso volcán de queso con una esponjosa base de brownie de chocolate.', 2.80, 8, 'Postres'),
	('Cookies', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/g7fog4lgse0twyjkan4x', 'Deliciosas galletas con pepitas de chocolate.', 1.65, 8, 'Postres'),
	('Vulcano de chocolate', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/ze3f7mwejtbgwuzcv0ba', 'Delicioso bizcocho de chocolate rellno de chocolate fundido.', 2.80, 8, 'Postres'),
	('Ben&Jerry''s Chocolate Fudge Brownie', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/ybmljlqtsb8nfdogycoi', 'Chocolate con bizcocho de chocolate (500ml).', 8.05, 8, 'Postres'),
	('Ben&Jerry''s Cookie Dough', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/muri23zls4694vnqldni', 'Vainilla con trozos de galleta con pepitas de chocolate y trocitos chocolateados (500ml).', 8.05, 8, 'Postres'),
	('Alitas de pollo', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/gv3uoou9opzmhjyqzaa2', 'Sabrosas alitas de pollo marinadas (6uds).', 4.70, 8, 'Complementos'),
	('Pan de ajo con queso (6uds)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/hfqinortfvpfhd9mxb0v', 'Crujiente pan de ajo tostado con queso 100% mozarella fundido ( 6uds).', 4.45, 8, 'Complementos'),
	/*TGB*/
	('Cheeseburger', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/1502805198', 'Cheeseburger.', 5.00, 9, 'Burgers'),
	('Cheeseburger XL', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/1502805198', 'Cheeseburger XL.', 6.00, 9, 'Burgers'),
	('TGB Burger', 'https://resizer.deliverect.com/D1g30zvn4BMBXH_-_a-cua247uUPP3VAwUnJvmqzsq4/rt:fill/w:1024/h:1024/g:ce/el:0/aHR0cHM6Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL2lrb25hLWJ1Y2tldC1wcm9kdWN0aW9uL2ltYWdlcy81ZjZiMmVkNmM5OTMwMjk3MzhhNjYzOGEvRVNUR0JDSDA1MDAzX1RHQiUyMEJVUkdFUi0xNjA2MjEwOTkxNzMxLmpwZw==', 'TGB Burger.', 5.50, 9, 'Burgers'),
	('BBQ Burger', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/1502805202', 'BBQ Burger.', 5.50, 9, 'Burgers'),
	('MED - Aros de Cebolla', 'https://resizer.deliverect.com/40ldkuJkOupPg-54E0y6A1wsFKftt6X1McYcc9QttGE/rt:fill/w:1024/h:1024/g:ce/el:0/aHR0cHM6Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL2lrb25hLWJ1Y2tldC1wcm9kdWN0aW9uL2ltYWdlcy81ZjZiMmVkNmM5OTMwMjk3MzhhNjYzOGEvRVNUR0JDQTA1MDEyX0FST1MlMjBERSUyMENFQk9MTEEtMTYwNjIxMDg3MjQzOC5qcGc=', 'Aros de Cebolla.', 3.75, 9, 'Aperitivos'),
	('MED - Bastón Sal', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/1502805170', 'Bastón Sal.', 3.75, 9, 'Aperitivos'),
	('MED - Cruj. Pollo & Nacho', 'https://resizer.deliverect.com/-GCyn6HIbYsQn2lr99jtjmeg8T-N0atpRxZRUqnyJV8/rt:fill/w:1024/h:1024/g:ce/el:0/aHR0cHM6Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL2lrb25hLWJ1Y2tldC1wcm9kdWN0aW9uL2ltYWdlcy81ZjZiMmVkNmM5OTMwMjk3MzhhNjYzOGEvRVNUR0JDQTA1MDIyX0NSVUpJRU5URVMlMjBERSUyMFBPTExPLTE2MDYyMTA4NzY0MjQuanBn', 'Cruj. Pollo & Nacho.', 3.75, 9, 'Aperitivos'),
	('Ensalada de la Huerta', 'https://resizer.deliverect.com/jlvDwqCM6pWDME2-v-_VtOvJkzwk3YZqsFa8KlA5KD0/rt:fill/w:1024/h:1024/g:ce/el:0/aHR0cHM6Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL2lrb25hLWJ1Y2tldC1wcm9kdWN0aW9uL2ltYWdlcy81ZjZiMmVkNmM5OTMwMjk3MzhhNjYzOGEvRVNUR0JDRTA1MDAxX0VOU0FMQURBJTIwREUlMjBMQSUyMEhVRVJUQS0xNjA2MjEwOTUxMDgxLmpwZw==', 'Ensalada de la Huerta.', 7.00, 9, 'Ensaladas'),
	('Ensalada César', 'https://resizer.deliverect.com/PopfKPV66QQccxZKTwVrpWkJdUtlZYuSK2fUXOdDruA/rt:fill/w:1024/h:1024/g:ce/el:0/aHR0cHM6Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL2lrb25hLWJ1Y2tldC1wcm9kdWN0aW9uL2ltYWdlcy81ZjZiMmVkNmM5OTMwMjk3MzhhNjYzOGEvRVNUR0JDRTA1MDAyX0VOU0FMQURBJTIwQyVDMyU4OVNBUi0xNjA2MjEwOTUxNDUzLmpwZw==', 'Ensalada César.', 7.00, 9, 'Ensaladas'),
	('EpicBowl', 'https://resizer.deliverect.com/8IshZQMeUhg3ciSl80bmaK3Q3jGUdhF9p4RBrj64hag/rt:fill/w:1024/h:1024/g:ce/el:0/aHR0cHM6Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL2lrb25hLWJ1Y2tldC1wcm9kdWN0aW9uL2ltYWdlcy81ZjZiMmVkNmM5OTMwMjk3MzhhNjYzOGEvRVNUR0JDQjA1MDA0X0VQSUMlMjBCT1dMLTE2MDYyMTA5MTg1MzUuanBn', 'EpicBowl.', 7.00, 9, 'Ensaladas'),
	/*Pans & Company*/
	('Menú Pans British Bacon', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/iombhu7wdmmq0uhb3w7n', 'Pan Provenzal, Bacon y Queso Edam fundido. Bocadillo (a escoger) + Complemento (a escoger) + Bebida (a escoger).', 7.70, 10, 'Menú Pans'),
	('Menú Pans Serrano Brie', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/hrizdnguysvdf0rwwceb', 'Pan Cristal, Jamón Serrano, Queso Brie fundido y Rúcula. Bocadillo (a escoger) + Complemento (a escoger) + Bebida (a escoger).', 8.50, 10, 'Menú Pans'),
	('Menú Pans Pechuga de Pollo', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/dm5bqjzutvmpkzryxdag', 'Pan Provenzal con tierno Pollo a la Plancha, Lechuga, Tomate en Rodajas, Especies BBQ y salsa Mayonesa. Bocadillo (a escoger) + Complemento (a escoger) + Bebida (a escoger).', 8.70, 10, 'Menú Pans'),
	('Menú Pans Breton', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/pgev4mmxtqdawswabmkr', 'Pan Provenzal, Lomo Adobado, Bacon y Queso Edam fundido. Bocadillo (a escoger) + Complemento (a escoger) + Bebida (a escoger).', 8.70, 10, 'Menú Pans'),
	('Menú Pans Iberico', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/medii0bprpdadgl7aovl', 'Pan Cristal con tomate, aceite de oliva y Jamón Ibérico. Bocadillo (a escoger) + Complemento (a escoger) + Bebida (a escoger).', 9.20, 10, 'Menú Pans'),
	('Ensalada Pasta', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/svf5e7iinmhcvrsal5ee', 'Pasta de colores en espirales, Mezclum de lechugas de Mix Campestre y Canónigos, Tomate seco, Mozzarella y Orégano.', 6.40, 10, 'Ensaladas'),
	('Ensalada Mediterránea', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/allxphnxk6wqykn5lv7e', 'Mezclum de lechugas de Mix Campestre y Canónigos, Tomate Cherry, Atún, Aceitunas, Huevo duro, Pimientos Asados y Maíz.', 6.40, 10, 'Ensaladas'),
	('Ensalada Quinoa', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/su5zehwo9huqxjfiq8hw', 'Quinoa, Mezclum de lechugas de Mix Campestre y Canónigos, Tomate Cherry, Queso Mozzarella, Pimientos Asados, Maíz y Sésamo Negro.', 6.40, 10, 'Ensaladas'),
	('Ensalada quinoa con heura vegan', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/lco8cnxjuxhczm8xfobd', 'Mix de lechugas y canónigos, heura, quinoa, tomate cherry, pimientos asados, maíz y sésamo Negro.', 6.40, 10, 'Ensaladas'),
	/*La Taquería*/
	('Mix Michelada (70 cl.)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/bet2bz9ueza9iqenbn6k', 'Preparado para hacerte la Michelada en casa.', 1.80, 11, 'Cervezas'),
	('Cerveza Pacífico (33cl)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/xvatrxuppwsabyayif7k', 'Cerveza Pacífico (33cl).', 3.50, 11, 'Cervezas'),
	('Cerveza Negra Modelo (33cl)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/fvqxoorfb0zrpjk2i6b6', 'Cerveza Negra Modelo (33cl).', 3.50, 11, 'Cervezas'),
	('Cerveza Coronita (33cl)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/snmacplkeq0yhkqyd113', 'Cerveza Coronita (33cl).', 3.50, 11, 'Cervezas'),
	('Tacos con arrachera (4uds.)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/hw8xhgjpkqbudwyfmsim', 'Tacos de ternera marinada coronados con cebolla y cilantro.', 9.40, 11, 'Tacos'),
	('Tacos de Tinga de pollo (4uds.)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/ffdsyfjmwrvzifie1mgo', 'Pollo desmechado con salsa de tomate y chipotle coronados con aguacate, crema, cebolla y cilantro.', 11.20, 11, 'Tacos'),
	('Tacos con bistec (4 uds.)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/wwn6y8lvqgahpilb6rid', 'Tacos con bistec, coronados con cebolla y cilantro.', 9.10, 11, 'Tacos'),
	('Frijoles refritos', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/tarejaawk9muw1fg6bsl', 'Frijoles refritos con longaniza acompañados de totopos (chips).', 5.90, 11, 'Entrantes'),
	('Jalapeños el de atrás paga', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/e42cw4zyocpfhftps1vq', 'Jalapeños rellenos de queso, bañados en salsa de jitomate, un toque de crema agria y chile pasilla tostado.', 6.50, 11, 'Entrantes'),
	('Nachos la cúcara', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/xpi3he2zwes7wlbjwmpy', 'Totopos gratinados con queso, frijoles refritos, pico de gallo, crema agria y jalapeños.', 9.10, 11, 'Entrantes'),
	/*Rostisseria Los Pollos*/
	('Pollo a l''ast', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/fldmg7bm92ugasdfohga', 'Pollo a l''ast.', 9.95, 12, 'Pollos a l''ast'),
	('Pollo a l''ast (1/2)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/fldmg7bm92ugasdfohga', 'Mig pollo a l''ast.', 5.50, 12, 'Pollos a l''ast'),
	('Pollo a l''ast (1/4)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/fldmg7bm92ugasdfohga', 'Un quart pollo a l''ast.', 3.00, 12, 'Pollos a l''ast'),
	('Codillo al horno (ración)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/pftssreskyjacigayq2s', 'Codillo al horno (ración).', 4.50, 12, 'Platos'),
	('Dorada al horno con guarnición', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/ys6fsqc9hinkbcaocpsl', 'Dorada al horno con guarnición.', 5.95, 12, 'Platos'),
	('Caracoles (ración)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/uxhepv8pchpncllqobdw', 'Caracoles (ración).', 4.95, 12, 'Platos'),
	('Bacalao con sanfaina (ración)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/avwy49nkbyobtjbg8wjt', 'Bacalao con sanfaina (ración).', 5.50, 12, 'Platos'),
	('Agua (50 cl.)', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/tgroylsti2mh7dgggtqf', 'Agua (50 cl.).', 1.20, 12, 'Bebidas'),
	('Fanta Naranja lata 330ml.', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/wr4r9cdrdjbbng5gz7lm', 'Fanta Naranja lata 330ml.', 1.80, 12, 'Bebidas'),
	/*Foster's Hollywood*/
	('Foster''s chicken pops', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/bsbxm0flpopk9kcbwv9q', 'Foster''s chicken pops.', 9.95, 13, 'Entrantes'),
	('Choice chicken fingers', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/yh3hxts2ebzspxttw5jy', 'Choice chicken fingers.', 9.85, 13, 'Entrantes'),
	('Finger de queso Grand Central', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/zg9avupfuqre4skxxvn9', 'Finger de queso Grand Central.', 9.35, 13, 'Entrantes'),
	('Nachos San Fernando', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/aepp9rk7axibek5xfoph', 'Con queso fundido, chili con carne, crema agria, jalapeños y pico de gallo.', 11.75, 13, 'Entrantes'),
	('Bacon & cheese fries', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/lcmfxecwhtqctka2wawd', 'Bacon & cheese fries.', 10.35, 13, 'Entrantes'),
	('Caesar sándwich', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/qdg73ivubicz4hrb1rna', 'Caesar sándwich.', 12.25, 13, 'Sándwiches'),
	('Pulled pork sándwich', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/jhww48ozwqnvfru5auyg', 'Pulled pork sándwich.', 12.25, 13, 'Sándwiches'),
	('Director''s Choice Veggie', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/crldjkyy0xt8cn34fc4h', 'Hamburguesa a base de proteína vegetal (Beyond Burger®), con lonchas veggie estilo cheddar y lonchas veggie estilo bacon, tomate en rodajas y cebolla morada con pan clásico..', 12.50, 13, 'Classic burgers'),
	('Director''s choice de pollo', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/ugczuxhhjg6he6s7pgwl', 'Director''s choice de pollo.', 12.05, 13, 'Classic burgers'),
	('Bacon burger de pollo', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/bkqfnjwu728cmbgeo3vk', 'Bacon burger de pollo.', 12.05, 13, 'Classic burgers'),
	('Director''s choice de ternera', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/pc22dbjsgxvb5fus6sjh', 'Director''s choice de ternera.', 10.95, 13, 'Classic burgers'),
	/*Santa Burg*/
	('Ensalada Santa Beata', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/s6glxzn7kgli9p7tg7zb', 'Con burrata, tomate y ensalada.', 9.90, 14, 'Ensaladas'),
	('Alitas de pollo ahumadas', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/pl8uayhfdqyvv7brww4m', 'Con mayonesa de kimchi.', 10.50, 14, 'Snacks'),
	('Nachos chilli cheese', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/l2oaxmdubxmy4fqsc88p', 'Chili con carne, queso y guacamole.', 12.50, 14, 'Snacks'),
	('Patatas caseras', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/rfuyoi4cekctvde0tzfc', 'Patatas caseras.', 4.50, 14, 'Snacks'),
	('Burger Bollywood', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/yfp0m4hntagbkam2cduq', 'Burger de pollo rebozado con tikka masala, tomate, lechuga y salsa tzatziky.', 9.90, 14, 'Burgers'),
	('Burger Santa Maraia', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/etf6djo5aeltxzxfxktl', 'Roast beef, cheddar, compota de manzana y frisse.', 10.90, 14, 'Burgers'),
	('Burger Santa Royal', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/oxrsube47lciuuy22cno', 'Vaca dry aged, cebolla confitada, mayo-mostaza, tomate, lechuga y bacon.', 10.70, 14, 'Burgers'),
	('Burger Santa Richard', 'https://res.cloudinary.com/glovoapp/w_600,h_500,c_fit,f_auto,q_auto/Products/nfsd639dljrz4xqbdqf0', 'Vaca dry aged, cebolla confitada, huevo frito, rúcula y foie gras.', 12.90, 14, 'Burgers');
	
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
