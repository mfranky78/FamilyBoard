class UserState {
  final String? imageUrl;
  final String? name;
  final String? email;
  // final String? team; // Du kannst auch Team hinzufügen, wenn du möchtest.

  UserState({this.imageUrl, this.name, this.email});

  UserState copyWith({String? imageUrl, String? name, String? email}) {
    return UserState(
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
