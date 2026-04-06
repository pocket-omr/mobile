class UserModel {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String email;

  UserModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.username,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? json['_id'] ?? '',
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
    };
  }
}
