// class CustomTeam {
//   String teamName;
//   String teamId;
//   List<dynamic> members;
//   List<dynamic> admins;
//   String name;

//   CustomTeam({
//     required this.teamName,
//     required this.admins,
//     required this.members,
//     required this.teamId,
//     required this.name,
//   });

//   // Factory-Methode zum Erstellen einer Instanz aus einer JSON-Map
//   factory CustomTeam.fromJson(Map<String, dynamic> json, String teamId) {
//     return CustomTeam(
//       teamName: json['teamName'],
//       teamId: teamId,
//       members: List<String>.from(json['members'] ?? []),
//       admins: List<String>.from(json['admins'] ?? []),
//       name: json['name'] ?? '',
//     );
//   }

//   // Methode zum Hinzufügen eines Mitglieds zum Team
//   void addMember(String memberId) {
//     members.add(memberId);
//   }

//   // Methode zum Konvertieren des Teams in eine JSON-Map
//   Map<String, dynamic> customTeamToJson() {
//     return {
//       'teamName': teamName,
//       'teamId': teamId,
//       'members': members,
//       'admins': admins,
//       'name': name,
//     };
//   }
// }
class CustomTeam {
  String teamName;
  String teamId;
  List<String> members;
  List<String> admins;
  String name;

  CustomTeam({
    required this.teamName,
    required this.teamId,
    required this.members,
    required this.admins,
    required this.name,
  });

  // Factory-Methode zum Erstellen einer Instanz aus einer JSON-Map
  factory CustomTeam.fromJson(Map<String, dynamic> json, String teamId, String creatorId) {
    List<String> membersList = List<String>.from(json['members'] ?? []);
    List<String> adminsList = List<String>.from(json['admins'] ?? []);

    // Fügt den Ersteller automatisch zu den Admins hinzu, wenn nicht bereits vorhanden
    if (!adminsList.contains(creatorId)) {
      adminsList.add(creatorId);
    }

    return CustomTeam(
      teamName: json['teamName'] ?? 'Unnamed Team',
      teamId: teamId,
      members: membersList,
      admins: adminsList,
      name: json['name'] ?? '',
    );
  }

  // Methode zum Hinzufügen eines Mitglieds zum Team
  void addMember(String memberId) {
    if (!members.contains(memberId)) {
      members.add(memberId);
    }
  }

  // Methode zum Entfernen eines Mitglieds
  void removeMember(String memberId) {
    members.remove(memberId);
  }

  // Methode zum Überprüfen, ob ein Benutzer Admin ist
  bool isAdmin(String userId) {
    return admins.contains(userId);
  }

  // Methode zum Konvertieren des Teams in eine JSON-Map
  Map<String, dynamic> toJson() {
    return {
      'teamName': teamName,
      'teamId': teamId,
      'members': members,
      'admins': admins,
      'name': name,
    };
  }
}
