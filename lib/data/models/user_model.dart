class UserModel {
  // Atributos privados garantindo o encapsulamento
  final int _id;
  final String _firstName;
  final String _lastName;
  final String _token;

  // Construtor
  UserModel({
    required int id,
    required String firstName,
    required String lastName,
    required String token,
  })  : _id = id,
        _firstName = firstName,
        _lastName = lastName,
        _token = token;

  // Getters para acessar os dados com segurança
  int get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get token => _token;

  // Factory para converter o Map (JSON) em Objeto
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      token: json['token'],
    );
  }

  // Polimorfismo demonstrado através da sobrescrita do método toString()
  @override
  String toString() {
    return 'UserModel(nome: $_firstName $_lastName)';
  }
}