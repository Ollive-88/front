import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ollive_front/models/user/user_model.dart';
import 'package:ollive_front/service/user/user_service.dart';

enum Actions { change, delete }

class FridgeInventoryScreen extends StatefulWidget {
  const FridgeInventoryScreen({super.key});

  @override
  State<FridgeInventoryScreen> createState() => _FridgeInventoryScreenState();
}

class _FridgeInventoryScreenState extends State<FridgeInventoryScreen> {
  late Future<List<UserIngredients>> ingredients;
  final TextEditingController _ingredientController = TextEditingController();
  var expirationDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    ingredients = UserService.getFridgeIngredients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('냉장고 관리'),
        surfaceTintColor: const Color(0xFFFFFFFC),
        shadowColor: Colors.black,
        elevation: 0,
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 130,
        child: FloatingActionButton.large(
          onPressed: () {
            _ingredientController.clear();
            showBottomSheet(
              context,
              null,
              null,
            );
          },
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF30AF98),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: const Text(
            '재료 추가하기',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder(
        future: ingredients,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return (snapshot.data!.isNotEmpty)
                ? Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Expanded(
                        child: SlidableAutoCloseBehavior(
                          closeWhenOpened: true,
                          child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    height: 0,
                                  ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final ingredient = snapshot.data![index];
                                return Slidable(
                                  key: Key(ingredient.name),
                                  startActionPane: ActionPane(
                                    extentRatio: 0.25,
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        backgroundColor:
                                            const Color(0xFF30AF98),
                                        label: '정보변경',
                                        onPressed: (context) {
                                          _updateText(ingredient.name);
                                          expirationDate =
                                              DateTime.parse(ingredient.endAt);
                                          showBottomSheet(
                                              context, index, snapshot.data!);
                                        },
                                      ),
                                    ],
                                  ),
                                  endActionPane: ActionPane(
                                    extentRatio: 0.2,
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        backgroundColor: Colors.red,
                                        label: '삭제',
                                        onPressed: (context) async {
                                          if (await UserService
                                              .deleteFridgeIngredients(
                                                  ingredient
                                                      .fridgeIngredientId!)) {
                                            setState(() {
                                              ingredients = UserService
                                                  .getFridgeIngredients();
                                            });
                                            _onDismissed(Actions.delete);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  child: buildIngredientListTitle(ingredient),
                                );
                              }),
                        ),
                      )
                    ],
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('아직 등록된 재료가 없어요.'),
                        Text('아래 버튼을 눌러 재료를 추가하세요.'),
                      ],
                    ),
                  );
          } else {
            return const Center(
              child: CircleAvatar(
                backgroundColor: Color(0xFFFFFFFC),
                backgroundImage: AssetImage("./assets/image/loding/Loding.gif"),
                radius: 60,
              ),
            );
          }
        },
      ),
    );
  }

  // bottomSheet
  Future<void> showBottomSheet(
      BuildContext context, int? index, List<UserIngredients>? ingredientList) {
    var initDate = index != null
        ? DateFormat('yyyy-MM-dd').parse(ingredientList![index].endAt)
        : DateTime.now();

    return showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFC),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '재료명',
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            width: 200,
                            height: 60,
                            child: TextField(
                              autofocus: true,
                              controller: _ingredientController,
                              cursorColor: const Color(0xFF30AF98),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide:
                                        BorderSide(color: Color(0xFF30AF98))),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            '유통기한',
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 120,
                        child: CupertinoDatePicker(
                          initialDateTime: initDate,
                          mode: CupertinoDatePickerMode.date,
                          minimumYear: initDate.year - 1,
                          onDateTimeChanged: (DateTime date) {
                            expirationDate = date;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_ingredientController.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                showToast('재료명을 입력해주세요.');
                              } else {
                                if (index != null) {
                                  final input = UserIngredients(
                                    name: _ingredientController.text,
                                    endAt: DateFormat('yyyy-MM-dd')
                                        .format(expirationDate),
                                    fridgeIngredientId: ingredientList![index]
                                        .fridgeIngredientId,
                                  );
                                  if (await UserService.putFridgeIngredients(
                                      input)) {
                                    setState(() {
                                      ingredients =
                                          UserService.getFridgeIngredients();
                                    });
                                    _onDismissed(Actions.change);
                                  }
                                } else {
                                  final newIngredient = UserIngredients(
                                      name: _ingredientController.text,
                                      endAt: DateFormat('yyyy-MM-dd')
                                          .format(expirationDate));
                                  // 추가 요청 보내기
                                  if (await UserService.postFridgeIngredients(
                                      newIngredient)) {
                                    setState(() {
                                      ingredients =
                                          UserService.getFridgeIngredients();
                                    });
                                  }
                                }
                                // 입력 필드 초기화
                                _ingredientController.clear();
                                expirationDate = DateTime.now();
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF30AF98),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: Text(
                              index != null ? '변경' : '추가',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _onDismissed(Actions action) {
    switch (action) {
      case Actions.delete:
        showToast('삭제되었습니다.');
      case Actions.change:
        showToast('변경되었습니다.');
    }
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
    );
  }

  void _updateText(txt) {
    setState(() {
      _ingredientController.text = txt;
    });
  }

  void _showSnackBar(BuildContext context, String msg, Color color) {
    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String calculateRemainingDate(initDateStr) {
    DateTime initDate = DateTime.parse(initDateStr);
    DateTime now = DateTime.now();

    DateTime today = DateTime(now.year, now.month, now.day);

    Duration difference = today.difference(initDate);

    if (difference.isNegative) {
      return '${difference.inDays.abs()}일 전';
    } else if (difference.inDays == 0) {
      return '오늘까지';
    } else {
      return '${difference.inDays}일 지남';
    }
  }

  Widget buildIngredientListTitle(UserIngredients ingredient) => Builder(
        builder: (context) {
          return ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: Text(
              ingredient.name,
              style: const TextStyle(fontSize: 15),
            ),
            trailing: Text(
              calculateRemainingDate(ingredient.endAt),
              style: const TextStyle(
                  color: Colors.red, fontSize: 13, fontWeight: FontWeight.w700),
            ),
            onTap: () {
              final slidable = Slidable.of(context)!;
              final isClosed =
                  slidable.actionPaneType.value == ActionPaneType.none;
              if (isClosed) {
                slidable.openStartActionPane();
              } else {
                slidable.close();
              }
            },
          );
        },
      );
}
