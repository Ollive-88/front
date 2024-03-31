class Login {
  late String name, password, email, token, refreshToken;

  Login.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        password = json['password'],
        email = json['email'];

  Login.fromUserInput()
      : email = '',
        password = '';

  Map<String, dynamic> toJson() => {
        'name': name,
        'password': password,
        'email': email,
      };
}

class SignIn {
  late String name, password, email, birthday, gender, nickname, role;

  SignIn.fromUserInput()
      : email = '',
        password = '',
        gender = '',
        birthday = '',
        name = '',
        nickname = '';
}

class ResponseDTO {
  int? code;
  String? msg;
  String? accessToken, refreshToken;

  ResponseDTO({
    this.code,
    this.msg,
  });

  ResponseDTO.fromJson()
      : code = 1,
        accessToken = '',
        refreshToken = '';
}

class UserIngredients {
  String name, endAt;
  int? fridgeIngredientId;

  UserIngredients({
    required this.name,
    required this.endAt,
    this.fridgeIngredientId,
  });

  UserIngredients.fromJson(Map<String, dynamic> json)
      : fridgeIngredientId = json['fridgeIngredientId'],
        name = json['name'],
        endAt = json['endAt'];
}

class HateIngredients {
  final String name;

  HateIngredients({
    required this.name,
  });
}

final hateIngredientList = [
  '감자',
  '양배추',
  '고추',
  '대추',
  '부추',
];
