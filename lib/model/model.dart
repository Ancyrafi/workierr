class Model {
  Model({
    required this.title,
    required this.description,
    required this.price,
    required this.id,
    required this.adress,
    required this.fullDescription,
    required this.phoneNumber,
    required this.userID,
    required this.creationTimestamp,
    required this.deleteTimestamp,
    required this.city
  });

  final String title;
  final String description;
  final String price;
  final String id;
  final String fullDescription;
  final String phoneNumber;
  final String adress;
  final String userID;
  final DateTime creationTimestamp;
  final DateTime deleteTimestamp;
  final String city;
}
