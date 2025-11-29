
const kPrimaryColor = 0xFFFFFFFF;
const kSecondaryColor = 0xFFF1F1F1;
const kTertiaryColor = 0xffdee2e6;

const kPlayerBackground = 0xff012a4a;
const kPlayerSecondaryColor = 0xff0077b6;

const kAuthFormVerticalSpacing = 20.0;

// const kServerBaseUrl = "http://10.0.2.2:8000/api/";
const kServerBaseUrl = "https://c6f406eb5e1a.ngrok-free.app/api/"; // test ngrok
const kSigninEndpoint = "signin";
const kSignupEndpoint = "signup";
const kAlbumTracksEndpoint = "tracks";
const kAlbumSearchEndpoint = "albums";
const kMaxNumberOfPlayers = 5;
const kRefreshTokenEndpoint = "signin/refresh";

const kRefreshTokenKey = "refresh_token";

var testSignin = {
  "email": "email",
  "password": "beybey"
};

enum LoadingScreenReasons{
  playAlbum,
}
