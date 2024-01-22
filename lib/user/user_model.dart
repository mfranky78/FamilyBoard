class CustomUser {
  String uid;
  String name;
  String? email;
  String? imageUrl;
  String? teamId;
  int? points;

  CustomUser(
      {required this.uid,
      required this.email,
      required this.imageUrl,
      required this.name,
      required this.teamId,
      this.points});

  factory CustomUser.fromJson(Map<String, dynamic> json) {
    return CustomUser(
        uid: json['userid'],
        email: json['email'],
        imageUrl: json['url'],
        name: json['name'],
        teamId: json['teamId'],
        points: json['points']);
  }

  Map<String, dynamic> customUserToJson() {
    return {
      'userid': uid,
      'name': name,
      'email': email,
      'url': imageUrl,
      'teamId': teamId,
      'points': points,
    };
  }
}
