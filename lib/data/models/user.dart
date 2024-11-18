class User {
  final int id;
  final String name;
  final String email;
  final String? image;
  final String? profession;
  final int? dateOfBirth;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    this.profession,
    this.dateOfBirth,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? image,
    String? profession,
    int? dateOfBirth,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      profession: profession ?? this.profession,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      image: json['image'] as String?,
      profession: json['profession'] as String?,
      dateOfBirth: json['dateOfBirth'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'profession': profession,
      'dateOfBirth': dateOfBirth,
    };
  }
}
