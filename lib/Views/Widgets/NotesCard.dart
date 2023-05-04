import 'package:flutter/material.dart';
import '../Screens/EditPage.dart';
import '../../Utils/DatabaseHelper.dart';

class NotesCard extends StatefulWidget {
  const NotesCard({Key? key}) : super(key: key);

  @override
  State<NotesCard> createState() => _NotesCardState();
}

List AllEntries = [];
Future _fetchdata() async {
  AllEntries = await DatabaseHelper.instance.queryAll();
}

class _NotesCardState extends State<NotesCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 370,
      child: ListView.builder(
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Dismissible(
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    final bool res = await showDialog(
                        context: _,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content:
                                const Text("Are you sure you want to delete ?"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () async {
                                  int rowsDeleted = await DatabaseHelper
                                      .instance
                                      .delete(AllEntries[index + 2]["_id"]);
                                  print(rowsDeleted);
                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                    return res;
                  } else {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (BuildContext context, animation,
                            secondaryAnimation) {
                          return EditPage(data: AllEntries[index]);
                        },
                      ),
                    );
                  }
                },
                background: slideRightBackground(),
                secondaryBackground: slideLeftBackground(),
                key: const Key('2/5/2023'),
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              AllEntries[index]["heading"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 147,
                            ),
                            Text(
                              AllEntries[index]["date"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          AllEntries[index]["content"],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: AllEntries.length),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.blueAccent,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.redAccent,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
