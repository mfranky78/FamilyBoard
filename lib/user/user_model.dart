
class CustomUser {
  String uid;
  String name;
  String email;
  String imageUrl;
  String member;
  String teamId;

  CustomUser(
      {required this.uid,
      required this.email,
      required this.imageUrl,
      required this.member,
      required this.name,
      required this.teamId});

  factory CustomUser.fromJson(Map<String, dynamic> json) {
    return CustomUser(
        uid: json['uid'],
        email: json['email'],
        imageUrl: json['imageUrl'],
        member: json['member'],
        name: json['name'],
        teamId: json['teamId']);
  }

  Map<String, dynamic> customUserToJson() {
    return {
      'userid': uid,
      'name': name,
      'email': email,
      'url': imageUrl,
      'member': member,
      'teamId': teamId,
    };
  }
}
