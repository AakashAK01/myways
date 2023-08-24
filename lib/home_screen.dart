import 'package:flutter/material.dart';
import 'package:myways_assignment/author_screen.dart';
import 'package:myways_assignment/database/mock_api_db.dart';
import 'package:myways_assignment/tag_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String? quote;
String? color;
String? author;
String? tags;
List<Map<String, dynamic>> _quotesList = [];

class _HomeScreenState extends State<HomeScreen> {
  bool isVertical = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final data = await QuotesDatabaseMock.getData();
    setState(() {
      _quotesList = data;
    });
  }

  void sheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Makes the sheet content scrollable
      builder: (context) {
        return ListView(
          padding: EdgeInsets.all(20.0),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "quote"),
              onChanged: (v) {
                setState(() {
                  quote = v;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "color"),
              onChanged: (v) {
                setState(() {
                  color = v;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "author"),
              onChanged: (v) {
                setState(() {
                  author = v;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "tag"),
              onChanged: (v) {
                setState(() {
                  tags = v;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await QuotesDatabaseMock.createData(
                    quote ?? "", color ?? "", author ?? "", tags ?? "");

                Navigator.pop(context);
                getData();
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 80, 10, 10),
          child: Column(children: [
            Row(
              children: [
                const Text(
                  "\"Quotes",
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox(width: 140),
                InkWell(
                  onTap: () {
                    setState(() {
                      isVertical = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: !isVertical
                          ? Color.fromARGB(255, 115, 188, 248)
                          : Colors.white,
                    ),
                    height: 30,
                    width: 30,
                    child: const Icon(
                      Icons.vertical_distribute,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: () async {
                    setState(() {
                      isVertical = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: isVertical
                          ? Color.fromARGB(255, 115, 188, 248)
                          : Colors.white,
                    ),
                    height: 30,
                    width: 30,
                    child: Icon(
                      Icons.horizontal_distribute,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: isVertical
                  ? PageView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _quotesList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 140.0),
                              child: Column(
                                children: [
                                  Text(
                                    _quotesList[index]['quotes'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: _quotesList[index]['color'] == 'bl'
                                          ? Color.fromARGB(255, 5, 73, 129)
                                          : _quotesList[index]['color'] == 'pi'
                                              ? Colors.pink
                                              : Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AuthorScreen(
                                                      author: _quotesList[index]
                                                          ['author'])));
                                    },
                                    child: Text(
                                      " - ${_quotesList[index]['author']}",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  _quotesList.isEmpty != true
                                      ? Column(
                                          children: [
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TagScreen(
                                                                    tag:
                                                                        "#motivational")));
                                                  },
                                                  child: Container(
                                                    height: 20,
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Color.fromARGB(
                                                            255,
                                                            151,
                                                            207,
                                                            252)),
                                                    child: Center(
                                                        child: Text(
                                                      "#motivational",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    )),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TagScreen(
                                                                      tag:
                                                                          "#truth")));
                                                    },
                                                    child: Container(
                                                      height: 20,
                                                      width: 70,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Color.fromARGB(
                                                              255,
                                                              151,
                                                              207,
                                                              252)),
                                                      child: Center(
                                                          child: Text(
                                                        "#truth",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    TagScreen(
                                                                      tag:
                                                                          "#poetry",
                                                                    )));
                                                  },
                                                  child: Container(
                                                    height: 20,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Color.fromARGB(
                                                            255,
                                                            151,
                                                            207,
                                                            252)),
                                                    child: Center(
                                                        child: Text(
                                                      "#poetry",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TagScreen(
                                                                    tag:
                                                                        "#love")));
                                                  },
                                                  child: Container(
                                                    height: 20,
                                                    width: 65,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Color.fromARGB(
                                                            255,
                                                            151,
                                                            207,
                                                            252)),
                                                    child: Center(
                                                        child: Text(
                                                      "#love",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    )),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TagScreen(
                                                                      tag:
                                                                          "#lifestyle")));
                                                    },
                                                    child: Container(
                                                      height: 20,
                                                      width: 85,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Color.fromARGB(
                                                              255,
                                                              151,
                                                              207,
                                                              252)),
                                                      child: Center(
                                                          child: Text(
                                                        "#lifestyle",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TagScreen(
                                                                    tag:
                                                                        "#happiness")));
                                                  },
                                                  child: Container(
                                                    height: 20,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Color.fromARGB(
                                                            255,
                                                            151,
                                                            207,
                                                            252)),
                                                    child: Center(
                                                        child: Text(
                                                      "#happiness",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(left: 70, right: 70),
                        child: Divider(
                          height: 20,
                          indent: 10,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      itemCount: _quotesList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Center(
                            child: ListTile(
                              title: Column(
                                children: [
                                  Text(
                                    _quotesList[index]['quotes'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: _quotesList[index]['color'] == 'bl'
                                          ? const Color.fromARGB(
                                              255, 5, 73, 129)
                                          : _quotesList[index]['color'] == 'pi'
                                              ? Colors.pink
                                              : Colors.green,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 180.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AuthorScreen(
                                                        author:
                                                            _quotesList[index]
                                                                ['author'])));
                                      },
                                      child: Text(
                                        " - ${_quotesList[index]['author']}",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // trailing: IconButton(
                              //   onPressed: () {
                              //     QuotesDatabaseMock.delete(
                              //         _quotesList[index]['id']);
                              //     getData();
                              //   },
                              //   icon: Icon(Icons.delete),
                              // ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ]),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: sheet,
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
