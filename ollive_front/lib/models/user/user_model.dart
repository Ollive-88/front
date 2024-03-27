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
