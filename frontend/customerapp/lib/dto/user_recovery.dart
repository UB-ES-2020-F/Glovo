class UserRecoveryDTO {
  int id;
  String newPassword;
  String email;
  String recoveryToken;
  UserRecoveryDTO({this.id, this.newPassword, this.email, this.recoveryToken});
  factory UserRecoveryDTO.fromJson(Map<String, dynamic> json) {
    return UserRecoveryDTO(
        id: (json.containsKey('id')) ? json['id'] : null,
        email: json['email'],
        recoveryToken:
            (json.containsKey('recoveryToken')) ? json['recoveryToken'] : null,
        newPassword:
            (json.containsKey('newPassword')) ? json['newPassword'] : null);
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> toReturn = {
      'email': email,
    };
    if (id != null) toReturn['id'] = id;
    if (newPassword != null) toReturn['newPassword'] = newPassword;
    if (recoveryToken != null) toReturn['recoveryToken'] = recoveryToken;
    return toReturn;
  }
}
