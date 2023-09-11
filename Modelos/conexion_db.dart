import 'package:postgres/postgres.dart';

Future<PostgreSQLConnection> conn() async {
  final db = PostgreSQLConnection("10.0.2.2", 5432, "new_garden",
      username: "postgres", password: "123456");

  await db.open();

  return db;
}
