namespace glovo_webapi.Services
{
    internal static class UserExceptionCodes
    {
        public const int InvalidCredentials = 0;
        public const int UserNotFound = 1;
        public const int BadPassword = 2;
        public const int EmailAlreadyExists = 3;
        public const int NoLoggedUser = 4;
    }

    internal static class OrderExceptionCodes
    {
        public const int RestaurantNotFound = 0;
        public const int UserNotFound = 1;
        public const int OrderNotFound = 2;
        public const int ProductNotFound = 3;
        public const int BadOrderProduct = 4;
        public const int ProductNotBelongingToRestaurant = 5;
    }

    internal static class RestaurantExceptionCodes
    {
        public const int RestaurantNotFound = 0;
    }
    
    internal static class ProductExceptionCodes
    {
        public const int RestaurantNotFound = 0;
        public const int ProductNotFound = 1;
    }
}