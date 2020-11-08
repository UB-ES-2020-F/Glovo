using System;

namespace glovo_webapi.Services.UserService
{
    static class UserExceptionCodes
    {
        public static int InvalidCredentials = 0;
        public static int UserNotFound = 1;
        public static int BadPassword = 2;
        public static int UserAlreadyExists = 3;
    }

    static class OrderExceptionCodes
    {
        public static int InvalidUser = 0;
        public static int RestaurantNotFound = 1;
        public static int ProductNotFound = 2;
        public static int BadOrderProduct = 3;
    }
}