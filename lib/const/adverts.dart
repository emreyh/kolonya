class Adverts {
  final String APP_MOB_ID = 'ca-app-pub-8437800262335443~4547257398';
  final String BANNER_ID = 'ca-app-pub-8437800262335443/9608012381';
  final String BANNER_ID_TEST = 'ca-app-pub-3940256099942544/6300978111';
  static const String INTERSTITIAL_ID = 'ca-app-pub-8437800262335443/2333879791';

  static final Adverts _instance = new Adverts._internal();
  factory Adverts() => _instance;
  static Adverts get instance => _instance;

  Adverts._internal();
}
