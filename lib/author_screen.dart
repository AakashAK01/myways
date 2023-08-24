import 'package:flutter/material.dart';

import 'database/mock_api_db.dart';

class AuthorScreen extends StatefulWidget {
  AuthorScreen({super.key, required this.author});
  String? author;

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

List<Map<String, dynamic>> _quotesList = [];

class _AuthorScreenState extends State<AuthorScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final data =
        await QuotesDatabaseMock.getQuotesByAuthor(widget.author ?? "");
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0), // Adjust as needed
                  child: Text(
                    widget.author?.toUpperCase() ?? "",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
