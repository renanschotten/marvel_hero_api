class UrlConstants {
  final String _baseUrl =
      'https://gateway.marvel.com:443/v1/public/characters?';
  final String _timeStamp = '1';
  final String _limit = '20';
  final String _apiKey = '1b6c18ad53addc7d2fd7036c1a9f6d13';
  final String _hash = '18e030e8dbdf6653439109dd92cf485a';

  String get url =>
      '${_baseUrl}ts=$_timeStamp&limit=$_limit&apikey=$_apiKey&hash=$_hash';
}
