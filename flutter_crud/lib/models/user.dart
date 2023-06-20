class User {
  final int? id;
  final String name;
  final String username;
  final String email;
  final String avatarUrl;

  const User(
      {this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.avatarUrl});
}
