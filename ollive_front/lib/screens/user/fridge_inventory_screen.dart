import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
            showModalBottomSheet<void>(
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      // height: 350,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '재료명',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 60,
                                  child: TextField(
                                    cursorColor: Color(0xFF30AF98),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          borderSide: BorderSide(
                                              color: Color(0xFF30AF98))),
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
                                mode: CupertinoDatePickerMode.date,
                                minimumYear: DateTime.now().year,
                                onDateTimeChanged: (DateTime date) {},
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                    onPressed: () {}, child: const Text('hi'))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF30AF98),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: const Text('재료 추가하기'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                        extentRatio: 0.4,
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: const Color(0xFF30AF98),
                            label: '유통기한 변경',
                            onPressed: (context) {
                              showdialog(context, index);
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

  void _onDismissed(int index, Actions action) {
    setState(() => ingredients.removeAt(index));

    switch (action) {
      case Actions.delete:
        _showSnackBar(context, '삭제되었습니다.', Colors.grey);
      case Actions.change:
        _showSnackBar(context, '변경되었습니다.', Colors.grey);
    }
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

  Future<dynamic> showdialog(BuildContext context, int index) {
    var initDate =
        DateFormat('yyyy-MM-dd').parse(ingredients[index].expirationDate);

    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        title: const Text(
          '유통기한 설정',
          style: TextStyle(fontSize: 18),
        ),
        content: SizedBox(
          height: 120,
          child: CupertinoDatePicker(
            initialDateTime: initDate,
            mode: CupertinoDatePickerMode.date,
            minimumYear: initDate.year,
            onDateTimeChanged: (DateTime date) {
              initDate = date;
            },
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                '취소',
                style: TextStyle(color: Colors.black54),
              )),
          TextButton(
              onPressed: () {
                setState(() {
                  ingredients[index].expirationDate =
                      DateFormat('yyyy-MM-dd').format(initDate);
                });
                Navigator.of(context).pop();
              },
              child: const Text('변경',
                  style: TextStyle(
                      color: Color(0xFF30AF98), fontWeight: FontWeight.w600))),
        ],
      ),
    );
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
