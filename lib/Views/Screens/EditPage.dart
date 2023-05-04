import 'package:flutter/material.dart';
import 'package:mynotes/Utils/DatabaseHelper.dart';

class EditPage extends StatefulWidget {
  int id;
  String title;
  String date;
  String note;
  EditPage({
    Key? key,
    required this.id,
    required this.date,
    required this.title,
    required this.note,
  }) : super(key: key);
  @override
  State<EditPage> createState() => _EditPageState();
}

var _title = "";
var _body = "";
var _date = "";

class _EditPageState extends State<EditPage> {
  Future<void> _selectDate(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
      context: ctx,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _date = picked.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _body = widget.note;
    _date = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Edit Note'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: _title,
                  hintStyle: const TextStyle(color: Color(0xffA4979797)),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                      width: 0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                        width: 0,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                onChanged: (String tval) => _title = tval,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _date.substring(0, 10),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      IconButton(
                          onPressed: () => _selectDate(context),
                          icon: const Icon(Icons.calendar_month_rounded)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                maxLines: 27,
                decoration: InputDecoration(
                  hintText: _body,
                  hintStyle: const TextStyle(color: Color(0xffA4979797)),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                        width: 0,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                        width: 0,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                onChanged: (String bval) => _body = bval,
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text('Edit'),
                ),
                onTap: () async {
                  await DatabaseHelper.instance.update({
                    DatabaseHelper.columnId: widget.id,
                    DatabaseHelper.columnDate: _date,
                    DatabaseHelper.columnHeading: _title,
                    DatabaseHelper.columnContent: _body
                  }).then((value) => {Navigator.of(context).pop(true)});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
