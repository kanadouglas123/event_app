class User {
  final int id;
  final String username;
  final String email;

  User({
    required this.id,
    required this.username,
    required this.email
  });

 factory User.fromJson(List<dynamic> json) {
  return User(
    id: int.parse(json.first['id'].toString()),
    username: json.first['username'].toString(),
     email: json.first['email'].toString(),
  );
}
}