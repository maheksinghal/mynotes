import 'package:flutter/material.dart';
import '/Views/Widgets/NotesCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
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
        child: Column(
          children: [
            const NotesCard(),
            SizedBox(
              height: MediaQuery.of(context).size.height - 615,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                    icon: const Icon(Icons.edit_note_rounded,
                        color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, '/add');
                    },
                  )),
            ),
          ],
        ),
      ),
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
    );
  }
}
