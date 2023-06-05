// Modelo de usuário

class UserModel {
  final int id;
  final String email;
  final String password;

  UserModel({required this.id, required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': email,
      'password': password,
    };
  }
}
