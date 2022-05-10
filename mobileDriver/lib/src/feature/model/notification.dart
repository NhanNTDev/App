class Notifications {
  final String title;
  final String body;
  final String time;

  Notifications({required this.title, required this.body, required this.time});

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      title: json['title'],
      time: json['time'],
      body: json['body'],
    );
  }

  // Magic goes here. you can use this function to from json method.
  static Notifications fromJsonModel(Map<String, dynamic> json) =>
      Notifications.fromJson(json);
}
