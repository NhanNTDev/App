class Pagination<T> {
  final int size;
  final int total;
  final int page;
  final List<T> items;

  Pagination(
      {required this.size,
      required this.total,
      required this.items,
      required this.page});

  factory Pagination.fromJson(
      Map<String, dynamic> json, Function fromJsonModel) {
    // print(json['data']['metadata']['size']);
    // print(json['data']['metadata']['total']);
    // print(json['data']['metadata']['page'],);
    // print(json['data']['data']);
    return Pagination<T>(
        size: json['data']['metadata']['size'],
        total: json['data']['metadata']['total'],
        page: json['data']['metadata']['page'],
        items: List<T>.from(
            json['data']['data'].map((itemsJson) => fromJsonModel(itemsJson))));
  }
}
