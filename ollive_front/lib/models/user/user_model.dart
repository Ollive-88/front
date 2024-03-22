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
  final String ingredientName, expirationDate;

  UserIngredients({
    required this.ingredientName,
    required this.expirationDate,
  });
}

final UserIngredientsList = [
  UserIngredients(
    ingredientName: '감자',
    expirationDate: '5일전',
  ),
  UserIngredients(
    ingredientName: '양파',
    expirationDate: '7일전',
  ),
  UserIngredients(
    ingredientName: '양배추',
    expirationDate: '8일전',
  ),
  UserIngredients(
    ingredientName: '고추',
    expirationDate: '10일전',
  ),
];
