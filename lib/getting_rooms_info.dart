class RoomInfo {
  final int id;
  final String name;
  final int price;
  final String pricePer;
  final List<dynamic> peculiarities;
  final List<dynamic> images;

  RoomInfo(
      {required this.id,
      required this.name,
      required this.price,
      required this.pricePer,
      required this.images,
      required this.peculiarities});

  factory RoomInfo.fromJson(Map<String, dynamic> json) {
    return RoomInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      pricePer: json['price_per'] as String,
      images: json['image_urls'],
      peculiarities: json['peculiarities'],
    );
  }

}
