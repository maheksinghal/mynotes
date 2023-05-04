import 'package:flutter/material.dart';
import '../../Utils/DatabaseHelper.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);
  @override
  State<AddNotes> createState() => _AddNotesState();
}

var _title = "";
var _body = "";

class _AddNotesState extends State<AddNotes> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
      context: ctx,
      initialDate: _selectedDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('New Note'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Color(0xffA4979797)),
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
                      horizontal: 10.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${_selectedDate.toLocal()}"
                            .split(' ')[0]
                            .replaceAll("-", "/"),
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
                  hintText: "What's on your mind ?",
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
                  child: const Text('Add'),
                ),
                onTap: () async {
                  int i = await DatabaseHelper.instance.insert({
                    DatabaseHelper.columnDate: _selectedDate.toString(),
                    DatabaseHelper.columnHeading: _title,
                    DatabaseHelper.columnContent: _body
                  });
                  print('The inserted id is $i');
                  setState(() {
                    _title = "";
                    _body = "";
                  });
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
