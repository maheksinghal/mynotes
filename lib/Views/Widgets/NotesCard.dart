import 'package:flutter/material.dart';
import '../Screens/EditPage.dart';
import '../../Utils/DatabaseHelper.dart';

class NotesCard extends StatefulWidget {
  String note;
  String date;
  String title;
  int id;
  NotesCard({
    Key? key,
    required this.date,
    required this.note,
    required this.title,
    required this.id,
  }) : super(key: key);

  @override
  State<NotesCard> createState() => _NotesCardState();
}

Future _deleteNote(int id) async {
  int rowDelete = await DatabaseHelper.instance.delete(id);
  return rowDelete;
}

class _NotesCardState extends State<NotesCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Dismissible(
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              final bool res = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text("Are you sure you want to delete ?"),
                    actions: <Widget>[
                      TextButton(
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          }),
                      TextButton(
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          _deleteNote(widget.id)
                              .then((value) => Navigator.of(context).pop(true));
                        },
                      ),
                    ],
                  );
                },
              );
              return res;
            } else {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder:
                      (BuildContext context, animation, secondaryAnimation) {
                    return EditPage(
                      id: widget.id,
                      title: widget.title,
                      date: widget.date,
                      note: widget.note,
                    );
                  },
                ),
              ).then((value) => setState(() {}));
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        widget.date.substring(0, 10),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.note,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) {
              return Dialog(
                backgroundColor: Colors.white,
                child: Container(
                  height: MediaQuery.of(context).size.height - 400,
                  width: MediaQuery.of(context).size.width - 50,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              widget.date.substring(0, 10),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              widget.note,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).primaryColor),
                            child: const Center(
                                child: Text(
                              "Close!",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
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
