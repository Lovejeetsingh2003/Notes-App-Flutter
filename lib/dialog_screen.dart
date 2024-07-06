import 'package:flutter/material.dart';
import 'package:sql_crud/crud_oject.dart';

class DialogScreen extends StatefulWidget {
  final String title;
  final String desc;
  const DialogScreen(this.title, this.desc, {super.key});

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.title.isNotEmpty) {
      titleController.text = widget.title;
    }
    if (widget.desc.isNotEmpty) {
      descController.text = widget.desc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Add Note",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: titleController,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                hintText: "Enter your Title",
                hintStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(width: 3, color: Colors.black),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: descController,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                hintText: "Enter your Description",
                hintStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(width: 3, color: Colors.black),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                style: TextButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  var object = CrudObject(
                    title: titleController.text.toString(),
                    description: descController.text.toString(),
                  );
                  Navigator.of(context).pop(object);
                },
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
