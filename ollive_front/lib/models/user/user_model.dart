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
  String? token, refreshToken;

  ResponseDTO({
    this.code,
    this.msg,
  });

  ResponseDTO.fromJson()
      : code = 1,
        token = '',
        refreshToken = '';
}

class UserIngredients {
  String ingredientName;
  String expirationDate;

  UserIngredients({
    required this.ingredientName,
    required this.expirationDate,
  });
}

class HateIngredients {
  final String ingredientName;

  HateIngredients({
    required this.ingredientName,
  });
}

final hateIngredientList = [
  '감자',
  '양배추',
  '고추',
  '대추',
  '부추',
];

final userIngredientsList = [
  UserIngredients(
    ingredientName: '감자',
    expirationDate: '2022-03-30',
  ),
  UserIngredients(
    ingredientName: '양파',
    expirationDate: '2023-03-30',
  ),
  UserIngredients(
    ingredientName: '양배추',
    expirationDate: '2024-03-30',
  ),
  UserIngredients(
    ingredientName: '고추',
    expirationDate: '2024-04-30',
  ),
  UserIngredients(
    ingredientName: '대추',
    expirationDate: '2024-03-25',
  ),
  UserIngredients(
    ingredientName: '카레',
    expirationDate: '2022-03-30',
  ),
];
