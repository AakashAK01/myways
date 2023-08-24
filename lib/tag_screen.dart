import 'package:flutter/material.dart';

import 'author_screen.dart';
import 'database/mock_api_db.dart';

class TagScreen extends StatefulWidget {
  TagScreen({super.key, required this.tag});
  String? tag;
  @override
  State<TagScreen> createState() => _TagScreenState();
}

List<Map<String, dynamic>> _quotesList = [];

class _TagScreenState extends State<TagScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final data = await QuotesDatabaseMock.getQuotesByTag(widget.tag ?? "");
    setState(() {
      _quotesList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 70, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.chevron_left),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 130.0),
                child: FittedBox(
                  child: Container(
                    height: 23,
                    width: 122,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 151, 207, 252)),
                    child: Center(
                      child: Text(
                        widget.tag ?? "",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
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
                                      ? const Color.fromARGB(255, 5, 73, 129)
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
                                            builder: (context) => AuthorScreen(
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
            ],
          ),
        ),
      ),
    );
  }
}
