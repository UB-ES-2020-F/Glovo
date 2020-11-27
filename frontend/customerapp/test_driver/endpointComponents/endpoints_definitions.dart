const _ENV = 'http://localhost:5000/api';
const CREATE_USER = '$_ENV/users/register';
const USER_LOGIN = '$_ENV/users/login';
const ORDERS = '$_ENV/orders';
const RESTAURANTS = '$_ENV/restaurants';
final RESTAURANT = (int idRestaurant) => '$RESTAURANTS/$idRestaurant';
final PRODUCTS_OF_RESTAURANT =
    (int idRestaurant) => '${RESTAURANT(idRestaurant)}/products';
final PRODUCTS_OF_RESTAURANT_BY_CATEGORY = (int idRestaurant, int idCategory) =>
    '${PRODUCTS_OF_RESTAURANT(idRestaurant)}?category=$idCategory';
final PRODUCTS_BY_CATEGORY =
    (int idCategory) => '$_ENV/products?category=$idCategory';

final CLOSEST_RESTAURANTS = (double latitude, double longitude) =>
    '$RESTAURANTS/closest?latitude=$latitude&longitude=$longitude';
