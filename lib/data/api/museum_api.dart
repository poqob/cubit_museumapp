import 'package:postgres/postgres.dart';

// research how to create an instance of database?

class Db {
  late final PostgreSQLConnection connection;
  Future<void> conn() async {
    connection = PostgreSQLConnection("localhost", 5432, "postgres",
        username: "postgres", password: "12345");
    await connection.open();
  }

  Future<void> connKill() async => await connection.close();

  //returns museums as list of list.
  Future<PostgreSQLResult> _museums() async {
    PostgreSQLResult result = await connection
        .query("select museum_id, museum, about_id from museums.museums;");
    return result;
  }

  Future<PostgreSQLResult> _aboutMuseum(int aboutId) async {
    PostgreSQLResult result = await connection.query(
        "select about_text, about_img from about.about_museum where about_id=$aboutId;");
    return result;
  }

  Future<List> get museumsResult async {
    var museum = await _museums();

    List res = [];
    for (List element in museum) {
      await _aboutMuseum(element.last).then((value) {
        //print("${element[1]}  ${value[0][0]}  ${value[0][1]}");
        res.add([element[1], value[0][0], value[0][1]]);
      });
    }
    return res;
  }
}
