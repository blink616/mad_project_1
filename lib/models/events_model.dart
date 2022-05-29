class EventModel {
  String? name;
  String? society_name;
  String? description;
  String? date;
  String? ticket_price;
  String? imageUrl;

  EventModel({this.name, this.society_name, this.description, this.date, this.ticket_price, this.imageUrl});

  // receiving data from server
  factory EventModel.fromMap(map) {
    return EventModel(
      name: map['name'],
      society_name: map['society_name'],
      date: map['date'],
      description: map['description'],
      ticket_price: map['ticket_price'],
      imageUrl: map['imageUrl'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'society_name': society_name,
      'date': date,
      'description':description,
      'ticket_price':ticket_price,
      'imageUrl':imageUrl
    };
  }
}