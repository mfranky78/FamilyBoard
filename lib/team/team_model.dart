
class CustomTeam {
  String teamName;
  String teamId;
  List<dynamic> members;
  List<dynamic> admins;
 

  CustomTeam(
      {required this.teamName,
      required this.admins,
      required this.members,
      required this.teamId});

  factory CustomTeam.fromJson(Map<String, dynamic> json, String teamId) {
    return CustomTeam(
        teamName: json['teamName'],
        teamId: teamId,
        members: json['members'],
        admins: json['admins']);
  }

  Map<String, dynamic> customTeamToJson() {
    return {
      'teamName': teamName,
      'teamId': teamId,
      'members': members,
      'admins': admins,
    };
  }
}
