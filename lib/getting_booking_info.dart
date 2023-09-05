// ignore_for_file: non_constant_identifier_names

class BookInfo {
  final int id;
  final String hotel_name;
  final String hotel_adress;
  final int horating;
  final String ratingName;
  final String departure;
  final String arrival_country;
  final String date_start;
  final String date_stop;
  final int num_nights;
  final String room;
  final String nutrition;
  final int tour_price;
  final int fuel_charge;
  final int service_charge;

  BookInfo(
      {required this.id,
      required this.hotel_name,
      required this.hotel_adress,
      required this.horating,
      required this.ratingName,
      required this.departure,
      required this.arrival_country,
      required this.date_start,
      required this.date_stop,
      required this.num_nights,
      required this.room,
      required this.nutrition,
      required this.tour_price,
      required this.fuel_charge,
      required this.service_charge});

  factory BookInfo.fromJson(Map<String, dynamic> json) {
    return BookInfo(
      id: json['id'] as int,
      hotel_name: json['hotel_name'] as String,
      hotel_adress: json['hotel_adress'] as String,
      horating: json['horating'] as int,
      ratingName: json['rating_name'] as String,
      departure: json['departure'] as String,
      arrival_country: json['arrival_country'] as String,
      date_start: json['tour_date_start'],
      date_stop: json['tour_date_stop'],
      num_nights: json['number_of_nights'] as int,
      room: json['room'] as String,
      nutrition: json['nutrition'] as String,
      tour_price: json['tour_price'],
      fuel_charge: json['fuel_charge'],
      service_charge: json['service_charge'] as int,
    );
  }
}
