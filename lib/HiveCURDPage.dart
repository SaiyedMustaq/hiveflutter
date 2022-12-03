

import 'package:flutter/material.dart';

import 'Address.dart';
import 'Person.dart';
import 'main.dart';

class HiveCURDPage extends StatefulWidget {
  const HiveCURDPage({Key? key}) : super(key: key);

  @override
  _HiveCURDPageState createState() => _HiveCURDPageState();
}

class _HiveCURDPageState extends State<HiveCURDPage> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();

  List<Person> personList = [];
  var _tapPosition;
  bool isEdit = false;
  int itemIndex = 0;
  @override
  void initState() {
    addressBox.put(
        0,
        Address()
          ..landmark = "Pd Pandya Collage"
          ..poncode = 254845);
    getPerson();
    print('ADDRESS BOX VALUE ${addressBox.get(0)}');

    super.initState();
  }

  void getPerson() async {
    personList = personTable.values.toList() as List<Person>;
    setState(() {});
  }

  void _showPopupMenu(Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: [
        PopupMenuItem(
            value: 1,
            child: Text(
              "View",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black),
            )),
        PopupMenuItem(
          value: 2,
          child: Text(
            "Edit",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.black),
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Text(
            "Delete",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.black),
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
// NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null

      if (value != null) print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final RenderObject? overlay =
        Overlay.of(context)!.context.findRenderObject();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(7, 15, 52, 1),
        title:const Text('Hive Crud'),
        actions: [
          IconButton(
              onPressed: () {
                if (name.text.isEmpty) return;
                if (age.text.isEmpty) return;
                FocusManager.instance.primaryFocus?.unfocus();
                if (isEdit) {
                  personTable.putAt(
                      itemIndex,
                      Person()
                        ..age = int.parse(age.text)
                        ..name = name.text);

                  isEdit = false;
                } else {
                  personTable.add(Person()
                    ..age = int.parse(age.text)
                    ..name = name.text);
                }
                personList.clear();
                name.clear();
                age.clear();
                getPerson();
              },
              icon: Icon(
                isEdit ? Icons.edit : Icons.save,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))),
              child: TextField(
                controller: name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.black),
                decoration:const InputDecoration(
                  hintText: 'Enter Name',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10.0)
                ),
              ),
            ),
           const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius:const BorderRadius.all(Radius.circular(10.0))),
              child: TextField(
                controller: age,
                keyboardType: TextInputType.number,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.black),
                decoration:const InputDecoration(hintText: 'Enter age',border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10.0)),
              ),
            ),
           const SizedBox(height: 20),
            Expanded(
              child: personList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (_, position) => Container(
                        height: 50,
                        child: ListTile(
                          onLongPress: () {
                            //_showPopupMenu(Offset(200, 200));
                          },
                          onTap: () {},
                          title: Text(
                            personList[position].name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black),
                          ),
                          leading: Text(
                            '${personList[position].age}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    isEdit = true;
                                    itemIndex = position;
                                    name.text =
                                        personList[position].name.toString();
                                    age.text =
                                        personList[position].age.toString();
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    personList.clear();
                                    personTable.deleteAt(position);
                                    getPerson();
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red.shade400,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      itemCount: personList.length,
                    )
                  : Center(
                      child: Text(
                        'No data found',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.black),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
