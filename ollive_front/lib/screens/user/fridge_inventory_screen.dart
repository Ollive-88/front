import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ollive_front/models/user/user_model.dart';

enum Actions { change, delete }

class FridgeInventoryScreen extends StatefulWidget {
  const FridgeInventoryScreen({super.key});

  @override
  State<FridgeInventoryScreen> createState() => _FridgeInventoryScreenState();
}

class _FridgeInventoryScreenState extends State<FridgeInventoryScreen> {
  List<UserIngredients> ingredients = userIngredientsList;
  DateTime today = DateTime.now();
  final TextEditingController _ingredientController = TextEditingController();
  var expirationDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('냉장고 관리'),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 130,
        child: FloatingActionButton.large(
          onPressed: () {
            _ingredientController.clear();
            showBottomSheet(context, null);
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
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: SlidableAutoCloseBehavior(
              closeWhenOpened: true,
              child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        height: 0,
                      ),
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = ingredients[index];
                    return Slidable(
                      key: Key(ingredient.ingredientName),
                      startActionPane: ActionPane(
                        extentRatio: 0.25,
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: const Color(0xFF30AF98),
                            label: '정보변경',
                            onPressed: (context) {
                              _updateText(ingredient.ingredientName);
                              showBottomSheet(context, index);
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
                            onPressed: (context) {
                              _onDismissed(index, Actions.delete);
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
      ),
    );
  }

  // bottomSheet
  Future<void> showBottomSheet(BuildContext context, int? index) {
    var initDate = index != null
        ? DateFormat('yyyy-MM-dd').parse(ingredients[index].expirationDate)
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
                  color: Colors.white,
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
                            onPressed: () {
                              if (_ingredientController.text.isEmpty) {
                                FocusScope.of(context).unfocus();
                                // 약간의 딜레이 후에 토스트 메시지를 띄운다.
                                Future.delayed(
                                    const Duration(milliseconds: 100), () {
                                  showToast();
                                });
                              } else {
                                if (index != null) {
                                  setState(() {
                                    ingredients[index].ingredientName =
                                        _ingredientController.text;
                                    ingredients[index].expirationDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(expirationDate);
                                  });
                                } else {
                                  final newIngredient = UserIngredients(
                                      ingredientName:
                                          _ingredientController.text,
                                      expirationDate: DateFormat('yyyy-MM-dd')
                                          .format(expirationDate));
                                  userIngredientsList.add(newIngredient);

                                  setState(() {});
                                }
                                // 입력 필드 초기화
                                _ingredientController.clear();
                                expirationDate = DateTime.now();
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

  void _onDismissed(int index, Actions action) {
    setState(() => ingredients.removeAt(index));

    switch (action) {
      case Actions.delete:
        _showSnackBar(context, '삭제되었습니다.', Colors.grey);
      case Actions.change:
        _showSnackBar(context, '변경되었습니다.', Colors.grey);
    }
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: '재료명을 입력해주세요.',
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
    DateTime today = DateTime.now();

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
              ingredient.ingredientName,
              style: const TextStyle(fontSize: 15),
            ),
            trailing: Text(
              calculateRemainingDate(ingredient.expirationDate),
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
