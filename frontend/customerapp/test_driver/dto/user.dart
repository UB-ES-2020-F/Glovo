class UserDTO {
  int id;
  String name;
  String password;
  String email;
  String token;
  UserDTO({this.id, this.name, this.password, this.email, this.token});
  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
        id: (json.containsKey('id')) ? json['id'] : null,
        email: json['email'],
        token: (json.containsKey('token')) ? json['token'] : null,
        password: (json.containsKey('password')) ? json['password'] : null,
        name: (json.containsKey('name')) ? json['name'] : null);
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> toReturn = {
      'email': email,
    };
    if (id != null) toReturn['id'] = id;
    if (name != null) toReturn['name'] = name;
    if (password != null) toReturn['password'] = password;
    if (token != null) toReturn['token'] = token;
    return toReturn;
  }
}
