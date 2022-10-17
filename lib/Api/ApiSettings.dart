class ApiSettings {
  // static const String _baseUrl = 'http://masa.resoen.com/';
  static const String baseUrl = 'http://176.126.87.26/';
  static const String _baseUrl2 = 'http://176.126.87.26/api/';
  static const String _baseApiUrl = baseUrl + 'api/';
  static const String login = _baseApiUrl + 'login';
  static const String getauth = _baseApiUrl + 'me';
  static const String logout = _baseApiUrl + 'logout';
  static const String register = _baseApiUrl + 'register';
  static const String forget = _baseApiUrl + 'send-forget-email-code';
  static const String reset = _baseApiUrl + 'reset-forgot-password';
  static const String images = _baseApiUrl + 'upload-files/{id}';
  //عشتن قصة رابط الصوره هان اخدن كلخ امجززز من رابط الي راجع في رسبونس
  static const String imageUrl = baseUrl + 'name/';
  static const String uploadimage = _baseApiUrl + 'upload-files';
  static const String getdimage = _baseApiUrl + 'files/images';
  static const String getdvideo = _baseApiUrl + 'files/videos';
  static const String getfiles = _baseApiUrl + 'files/all';
  static const String createfolder = _baseApiUrl + 'create-folder';
  static const String updateprofile = _baseApiUrl + 'update-profile';
  static const String sortfolder = _baseApiUrl + 'images-by-folder/';
  static const String imagebydate = _baseApiUrl + 'images-by-days';
  static const String searchApi = _baseApiUrl + 'files/search';
  static const String sendVerifiedEmail =
      _baseApiUrl + 'send-email-verification';
  static const String verifiedEmail = _baseApiUrl + 'verify-email';
}
