import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sql_crud/crud_oject.dart';
import 'package:sql_crud/db_provider.dart';
import 'package:sql_crud/dialog_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var list = <CrudObject>[];
  var dbProvider = DbProvider();
  @override
  void initState() {
    super.initState();
    getList();
  }

  void getList() async {
    list.addAll(await dbProvider.getData());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "Notes App",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: list.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = list[index];
                  return Card(
                    color: Colors.lightBlue[100],
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                item.title ?? "",
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                item.description ?? "",
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => DialogScreen(
                                        item.title ?? "",
                                        item.description ?? ""),
                                  ).then((value) {
                                    value.id = list[index].id;
                                    dbProvider.updateData(
                                        value, list[index].id ?? 0);
                                    list.clear();
                                    getList();
                                    setState(() {});
                                  });
                                },
                                child: const Icon(
                                  Icons.edit,
                                  size: 35,
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Note Delete"),
                                        content: const Text(
                                            "Do You Want To Delete this Notes?"),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              dbProvider.deleteData(item);
                                              Navigator.of(context).pop();
                                              list.clear();
                                              getList();
                                              setState(() {});
                                            },
                                            child: const Text("Yes"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("No"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.delete,
                                  size: 35,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const DialogScreen("", ""),
          ).then((value) {
            var object = value as CrudObject;
            dbProvider.insertData(object);
            list.clear();
            getList();
            setState(() {});
          });
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
