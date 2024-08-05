class User {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  String senha;

  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.avatarUrl,
      required this.senha});
}
