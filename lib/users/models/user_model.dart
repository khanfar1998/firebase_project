class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? phoneNumber;
  final String userRole;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.phoneNumber,
    required this.userRole,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'],
      userRole: map['userRole'] ?? 'user',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'userRole': userRole,
    };
  }
}
