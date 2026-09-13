class UserModel {
  final String firstName;
  final String lastName;

  UserModel({
    required this.firstName,
    required this.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // O operador ?? garante que se o JSON vier nulo, a string será substituída por um valor padrão seguro
      firstName: json['firstName'] ?? 'Usuário',
      lastName: json['lastName'] ?? '',
    );
  }
}