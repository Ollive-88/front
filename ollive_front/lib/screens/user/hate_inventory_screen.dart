import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ollive_front/models/user/user_model.dart';

class HateInventoryScreen extends StatefulWidget {
  const HateInventoryScreen({super.key});

  @override
  State<HateInventoryScreen> createState() => _HateInventoryScreenState();
}

class _HateInventoryScreenState extends State<HateInventoryScreen> {
  List<String> ingredients = hateIngredientList;
  Set<String> ingredientSet = hateIngredientList.toSet();

  final TextEditingController _ingredientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('싫어하는 재료 목록'),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 130,
        child: FloatingActionButton.large(
          onPressed: () {
            showdialog(context);
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
                      key: Key(ingredient),
                      endActionPane: ActionPane(
                        extentRatio: 0.2,
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: Colors.red,
                            label: '삭제',
                            onPressed: (context) {
                              _onDismissed(index);
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

  Future<dynamic> showdialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        title: const Text(
          '재료 추가하기',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '재료명',
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(
                width: 20,
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
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Color(0xFF30AF98))),
                  ),
                ),
              )
            ],
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
                if (_ingredientController.text.isEmpty) {
                  showToast(context, '재료명을 입력해주세요.');
                } else {
                  if (ingredientSet.contains(_ingredientController.text)) {
                    showToast(context, '이미 목록에 있는 재료입니다.');
                    _ingredientController.clear();
                  } else {
                    setState(() {
                      // api 연결하기
                      ingredients.add(_ingredientController.text);
                      ingredientSet.add(_ingredientController.text);
                    });
                    _ingredientController.clear();
                    Navigator.of(context).pop();
                  }
                }
              },
              child: const Text('추가',
                  style: TextStyle(
                      color: Color(0xFF30AF98), fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  void _onDismissed(int index) {
    setState(() {
      ingredientSet.remove(ingredients[index]);
      ingredients.removeAt(index);
    });
    _showSnackBar(context, '삭제되었습니다.');
  }

  void showToast(context, msg) {
    FocusScope.of(context).unfocus();
    // 약간의 딜레이 후에 토스트 메시지를 띄운다.
    Future.delayed(const Duration(milliseconds: 100), () {
      Fluttertoast.showToast(
        msg: msg,
      );
    });
  }

  void _showSnackBar(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.grey.shade300,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildIngredientListTitle(String ingredient) => Builder(
        builder: (context) {
          return ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: Text(
              ingredient,
              style: const TextStyle(fontSize: 15),
            ),
            onTap: () {
              final slidable = Slidable.of(context)!;
              final isClosed =
                  slidable.actionPaneType.value == ActionPaneType.none;
              if (isClosed) {
                slidable.openEndActionPane();
              } else {
                slidable.close();
              }
            },
          );
        },
      );
}