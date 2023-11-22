
class CustomTeam {
  String teamName;
  String teamId;
  String member;
  bool admin;
 

  CustomTeam(
      {required this.teamName,
      required this.admin,
      required this.member,
      required this.teamId});

  factory CustomTeam.fromJson(Map<String, dynamic> json) {
    return CustomTeam(
        teamName: json['teamName'],
        teamId: json['teamId'],
        member: json['member'],
        admin: json['admin']);
  }

  Map<String, dynamic> customTeamToJson() {
    return {
      'teamName': teamName,
      'teamId': teamId,
      'member': member,
      'admin': admin,
    };
  }
}
