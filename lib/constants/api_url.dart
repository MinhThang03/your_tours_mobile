//domain
const String domain = "https://your-tours.herokuapp.com";
// const String domain = "http://10.20.1.168:9080";

//auth api
const String loginUrl = "/api/v1/auth/login";
const String activeOtpUrl = "/api/v1/auth/active-account";
const String registerUrl = "/api/v1/auth/register";

//app api
const String getListProvince = "/api/v1/public/app/provinces/list";
const String getUserProfile = "/api/v1/user/profile";
const String getHomePage = "/api/v1/app/homes/page?number=0&size=10{sort}";
const String getHomeRecommend =
    "/api/v1/app/homes/page/recommend?number=0&size=10";
const String homePageFilterUrl =
    "/api/v1/app/homes/page/filter?number=0&size=20";
const String amenitiesFilterUrl =
    "/api/v1/public/amenities/page/set-filter?number=0&size=20";
const String favouriteUrl = "/api/v1/app/favorites/handle";
const String favouritePageUrl = "/api/v1/app/favorites/pages?number=0&size=20";
const String homeDetailUrl = "/api/v1/public/homes/{homeId}/detail";
const String checkBookingUrl = "/api/v1/app/booking/check";
const String getPriceOfHomeUrl =
    "/api/v1/public/prices?{homeId}&{dateFrom}&{dateTo}";
const String createBookingUrl = "/api/v1/app/booking/create";
const String getPageBookingUrl = "/api/v1/mobile/booking/page?number=0&size=20";
const String cancelBookingUrl = "/api/v1/app/booking/cancel";
const String getLocation = "/api/v1/public/location";

//mobile api
const String getMobileHomePage =
    "/api/v1/mobile/homes/page?number=0&size=10{sort}";
const String getMobileHomeFavorite =
    "/api/v1/mobile/homes/favorites?number=0&size=10";
const String getMobileHomePageFilter =
    "/api/v1/mobile/homes/page/filter?number=0&size=10";
