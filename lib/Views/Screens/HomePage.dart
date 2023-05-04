import 'package:flutter/material.dart';
import '../../Utils/DatabaseHelper.dart';
import '/Views/Widgets/NotesCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List AllEntries = [];
Future _fetchdata() async {
  AllEntries = await DatabaseHelper.instance.queryAll();
  print(AllEntries);
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "All Notes",
        ),
        centerTitle: false,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _fetchdata(),
            builder: (cont, snapshot) {
              return ListView.builder(
                itemBuilder: (ctx, index) {
                  return NotesCard(
                    date: AllEntries[index]["date"],
                    note: AllEntries[index]["content"],
                    title: AllEntries[index]["heading"],
                    id: AllEntries[index]["_id"],
                  );
                },
                itemCount: AllEntries.length,
              );
            },
          )),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.white),
        child: Drawer(
          width: MediaQuery.of(context).size.width - 110,
          backgroundColor: Theme.of(context).primaryColor,
          child: GestureDetector(
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                    child: Text(
                      "Home",
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                  )),
              onTap: () {
                Navigator.pop(context, false);
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add').then((_) => setState(() {}));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.edit_note_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
