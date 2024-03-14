class Login {
  late String accountName;
  late String password;
  late String userId;

  Login.fromJson(Map<String?, dynamic> json)
      : accountName = json['accountName'],
        password = json['password'],
        userId = json['userId'];

  Login.fromUserInput();

  Map<String, dynamic> toJson() => {
        'accountName': accountName,
        'password': password,
        'userId': userId,
      };
}
