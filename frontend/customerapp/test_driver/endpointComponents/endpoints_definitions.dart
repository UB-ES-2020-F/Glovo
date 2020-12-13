const _ENV = 'http://localhost:5000/api';
const CREATE_USER = '$_ENV/users/register';
const USER_LOGIN = '$_ENV/users/login';
const ORDERS = '$_ENV/orders';
const RESTAURANTS = '$_ENV/restaurants';
// ignore: non_constant_identifier_names
final RESTAURANT = (int idRestaurant) => '$RESTAURANTS/$idRestaurant';
// ignore: non_constant_identifier_names
final PRODUCTS_OF_RESTAURANT =
    (int idRestaurant) => '${RESTAURANT(idRestaurant)}/products';
// ignore: non_constant_identifier_names
final PRODUCTS_OF_RESTAURANT_BY_CATEGORY = (int idRestaurant, int idCategory) =>
    '${PRODUCTS_OF_RESTAURANT(idRestaurant)}?category=$idCategory';
// ignore: non_constant_identifier_names
final PRODUCTS_BY_CATEGORY =
    (int idCategory) => '$_ENV/products?category=$idCategory';
// ignore: non_constant_identifier_names
final CLOSEST_RESTAURANTS = (double latitude, double longitude) =>
    '$RESTAURANTS/closest?latitude=$latitude&longitude=$longitude';
final CHANGE_USER_AND_EMAIL = '$_ENV/users/update';
final CHANGE_PASSWORD = '$_ENV/users/update-password';
