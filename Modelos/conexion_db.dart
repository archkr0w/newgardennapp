import 'package:postgres/postgres.dart';

Future<PostgreSQLConnection> conn() async {
  final db = PostgreSQLConnection("IP", "PORT", "new_garden",
      username: "(usuario)", password: "1234567847348");

  await db.open();

  return db;
}
