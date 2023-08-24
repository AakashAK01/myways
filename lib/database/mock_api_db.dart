import 'package:myways_assignment/home_screen.dart';
import 'package:sqflite/sqflite.dart' as sql;

class QuotesDatabaseMock {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''CREATE TABLE quotesDb (
                     id INTEGER PRIMARY KEY AUTOINCREMENT,
                    quotes TEXT,
                    color TEXT,
                    author TEXT,
                    tags TEXT
                    )''');
  }

  static Future<sql.Database> db() {
    return sql.openDatabase('quoteList1.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      print("Rukko Jara saba karo Db Creating ho rahe hai");
      await createTables(database);
    });
  }

  static Future<int?> createData(
      String quote, String color, String author, String tags) async {
    final db = await QuotesDatabaseMock.db();
    final data = {
      'quotes': quote,
      'color': color,
      'author': author,
      'tags': tags
    };

    final id = await db.insert(
      'quotesDb',
      data,
    );
    final allRows = await db.query('quotesDb');
    print('All rows in quotesDb:');
    allRows.forEach((row) {
      print(
          'ID: ${row['id']}, Quote: ${row['quotes']}, Color: ${row['color']}, Author: ${row['author']}');
    });

    return id;
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await QuotesDatabaseMock.db();
    print(db.query('quotesDb', orderBy: "id"));
    return db.query('quotesDb', orderBy: "id");
  }

  static Future<void> delete(int id) async {
    final db = await QuotesDatabaseMock.db();
    try {
      await db.delete("quotesDb", where: "id=?", whereArgs: [id]);
      print("Deleted row with id: $id");
    } catch (error) {
      print("Error while deleting row: $error");
    }
  }

  static Future<List<Map<String, dynamic>>> getQuotesByAuthor(
      String author) async {
    final db = await QuotesDatabaseMock.db();
    final List<Map<String, dynamic>> result = await db.query(
      'quotesDb',
      where: "author = ?",
      whereArgs: [author],
    );
    return result;
  }

  static Future<List<Map<String, dynamic>>> getQuotesByTag(String tags) async {
    final db = await QuotesDatabaseMock.db();
    final List<Map<String, dynamic>> result = await db.query(
      'quotesDb',
      where: "tags = ?",
      whereArgs: [tags],
    );
    return result;
  }
}
