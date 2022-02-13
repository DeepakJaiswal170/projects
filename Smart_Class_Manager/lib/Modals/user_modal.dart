class User {
  final int id;
  final String fullName;
  final String dept;
  final int sem;
  final String mail;
  final String token;
  final String usertype;

  User(
      {this.id,
      this.fullName,
      this.dept,
      this.sem,
      this.mail,
      this.token,
      this.usertype});

  User.fromJson(Map<String, dynamic> parsedJson, this.token, this.usertype)
      : id = parsedJson['_id'],
        fullName = parsedJson['fullName'],
        dept = parsedJson['dept'],
        sem = parsedJson['sem'],
        mail = parsedJson['mail'];
}
