class NotificationContent {
  final String title;
  final String body;
  final String confirmationMessage;

  const NotificationContent(this.title, this.body, this.confirmationMessage);

  static const handWashing = NotificationContent(
      'Ellerini Yıkama Zamanı!',
      'Ellerini yıkama zamanı geldi. Hadi ellerini en az 20 sn boyunca bol köpükle yıka.',
      'Ellerini yıkadıysan bunu günlüğü kaydedelim mi?');

  static const shower = NotificationContent(
      'Duş Zamanı!',
      'Düzenli duş alarak virüslerden korunabilirsin. Bu gün duş aldın mı?',
      'Duş aldıysan bunu günlüğe kaydedelim mi?');

  static const cleanSmartphone = NotificationContent(
      'Telefonunu Dezenfekte Etme Zamanı!',
      'Telefonunu dezenfekte etme zamanı geldi. Virüslerden korunmak için telefonunu temiz tut!',
      'Telefonunu temizlediysen bunu günlüğe kaydedelim mi?');

  static const cleanHome = NotificationContent(
      'Ev Temizliği Zamanı!',
      'Evini temiz tut, kapı kollarını ve ortak kullanım alanlarını dezenfekte et.',
      'Evini temizlediysen bunu günlüğe kaydedelim mi?');

  static List<NotificationContent> get values =>
      [handWashing, cleanSmartphone, cleanHome, shower];

  static NotificationContent elementAt(int index) {
    return values.elementAt(index);
  }
}
