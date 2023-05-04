import 'package:flutter/material.dart';
import 'package:mynotes/Utils/DatabaseHelper.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key, required this.data}) : super(key: key);
  final Map data;
  @override
  State<EditPage> createState() => _EditPageState();
}

var _title = "";
var _body = "";

class _EditPageState extends State<EditPage> {
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

  void initState() {
    super.initState();
    _title = widget.data["heading"];
    _body = widget.data["content"];
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
                  hintStyle: TextStyle(color: Color(0xffA4979797)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                      width: 0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${_selectedDate.toLocal()}"
                            .split(' ')[0]
                            .replaceAll("-", "/"),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 174,
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
                  hintStyle: TextStyle(color: Color(0xffA4979797)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                        width: 0,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
                  int rowsUpdated = await DatabaseHelper.instance.update({
                    DatabaseHelper.columnId: widget.data["_id"],
                    DatabaseHelper.columnDate: _selectedDate,
                    DatabaseHelper.columnHeading: _title,
                    DatabaseHelper.columnContent: _body
                  });
                  print('The inserted id is $rowsUpdated');
                  setState(() {
                    _title = "";
                    _body = "";
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
