//domain
const String domain = "https://your-tours.herokuapp.com";

//auth api
const String loginUrl = "/api/v1/auth/login";
const String activeOtpUrl = "/api/v1/auth/active-account";
const String registerUrl = "/api/v1/auth/register";

//app api
const String getUserProfile = "/api/v1/user/profile";
const String homePageFilterUrl =
    "/api/v1/app/homes/page/filter?number=0&size=20";
const String amenitiesFilterUrl =
    "/api/v1/public/amenities/page/set-filter?number=0&size=20";
const String favouriteUrl = "/api/v1/app/favorites/handle";
const String favouritePageUrl = "/api/v1/app/favorites/pages?number=0&size=20";
const String homeDetailUrl = "/api/v1/public/homes/{homeId}/detail";
const String checkBookingUrl = "/api/v1/app/booking/check";
