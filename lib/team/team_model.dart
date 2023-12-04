class CustomTeam {
  String teamName;
  String teamId;
  List<dynamic> members;
  List<dynamic> admins;
  String uid;

  CustomTeam({
    required this.teamName,
    required this.admins,
    required this.members,
    required this.teamId,
    required this.uid,
  });

  // Factory-Methode zum Erstellen einer Instanz aus einer JSON-Map
 factory CustomTeam.fromJson(Map<String, dynamic> json, String teamId) {
  return CustomTeam(
    teamName: json['teamName'],
    teamId: teamId,
    members: List<String>.from(json['members'] ?? []),
    admins: List<String>.from(json['admins'] ?? []),
    uid: json['userid'] ?? '', // Hier kannst du den leeren String oder einen Standardwert setzen
  );
}


  // Methode zum Hinzufügen eines Mitglieds zum Team
  void addMember(String memberId) {
    members.add(memberId);
  }

  // Methode zum Konvertieren des Teams in eine JSON-Map
   Map<String, dynamic> customTeamToJson() {
    return {
      'teamName': teamName,
      'teamId': teamId,
      'members': members,
      'admins': admins,
      'userid': uid,
    };
  }
}
