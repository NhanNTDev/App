class FeedbackInFarm {
  final int? id;
  final String customerName;
  final num star;
  final String content;
  final String image;
  final String feedBackCreateAt;
  final int orderId;

  const FeedbackInFarm(
      {this.id,
      required this.customerName,
      required this.star,
      required this.content,
      required this.image,
      required this.feedBackCreateAt,
      required this.orderId});

  factory FeedbackInFarm.fromJson(Map<String, dynamic> json) {
    return FeedbackInFarm(
      id: json['id'],
      customerName: json['customerName'],
      star: json['star'],
      content: json['content'],
      image: json['image'],
      feedBackCreateAt: json['feedBackCreateAt'],
      orderId: json['orderId'],
    );
  }

  static FeedbackInFarm fromJsonModel(Map<String, dynamic> json) =>
      FeedbackInFarm.fromJson(json);
}
