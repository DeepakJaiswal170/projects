class Post {
  String username;
  String coverImage;
  String id;
  String title;
  String dept;
  String year;
  DateTime created;

  Post({
    this.id,
    this.username,
    this.title,
    this.coverImage,
    this.dept,
    this.year,
    //this.created,
  });

  Post.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['_id'],
        username = parsedJson['username'],
        title = parsedJson['title'],
        coverImage = parsedJson['coverImage'],
        dept = parsedJson['dept'],
        year = parsedJson['year'];
  //created = parsedJson['created'];

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "title": title,
        "coverImage": coverImage,
        "dept": dept,
        "year": year,
      };
}
