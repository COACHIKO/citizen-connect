class Report {
  final String id;
  final String image;
  final String description;
  final String location;
  final String status;
  final DateTime createdAt;
  final User user;
  final String category;

  Report({
    required this.id,
    required this.image,
    required this.description,
    required this.location,
    required this.status,
    required this.createdAt,
    required this.user,
    required this.category,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      image: json['image'],
      description: json['description'],
      location: json['location'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      user: User.fromJson(json['user']),
      category: json['category'],
    );
  }
}

class User {
  final String phone;
  final String fullName;

  User({
    required this.phone,
    required this.fullName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      phone: json['phone'],
      fullName: json['full_name'],
    );
  }
}
