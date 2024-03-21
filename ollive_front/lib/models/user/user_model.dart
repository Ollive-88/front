class Login {
  late String userName, password, userId;

  Login.fromJson(Map<String?, dynamic> json)
      : userName = json['userName'],
        password = json['password'],
        userId = json['userId'];

  Login.fromUserInput()
      : userId = '',
        password = '';

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'password': password,
        'userId': userId,
      };
}

class SignIn {
  late String userName, password, userId, birth, gender;

  SignIn.fromUserInput()
      : userId = '',
        password = '',
        userName = '',
        birth = '',
        gender = '';
}
