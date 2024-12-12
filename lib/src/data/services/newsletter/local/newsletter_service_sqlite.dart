import 'dart:async';

import 'package:newsletter/src/core/helper/sqlite_helper.dart';
import 'package:newsletter/src/data/models/newsletter/newsletter_local.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/config/databases/sqlite_config.dart';
import 'newsletter_service_local.dart';

class NewsletterServiceSqlite extends NewsletterServiceLocal {
  static const table = 'Newsletter';

  final String dbPath;
  final int dbVersion;
  final List<String> onCreate;

  NewsletterServiceSqlite(
      {required this.dbPath, required this.dbVersion, required this.onCreate})
      : super(BehaviorSubject<List<NewsletterLocal>>.seeded([])) {
    loadNewsletters();
  }

  Future<void> loadNewsletters() async {
    final db = await SQLiteHelper.getDatabase(dbPath, dbVersion, onCreate);
    final newsletterDBReturn =
        await SQLiteHelper.runSelectSql('select * from $table', db, []);
    final newsletterMap = newsletterDBReturn
        .map((e) => NewsletterLocal.fromJson(json: e))
        .toList();
    subject.add(newsletterMap);
  }

  @override
  Future<void> addNewsletter(NewsletterLocal newsletter) async {
    final db = await SQLiteHelper.getDatabase(
        SQLiteConfig.dbPath, SQLiteConfig.dbVersion, SQLiteConfig.onCreate);
    try {
      await SQLiteHelper.runInsertSql(table, newsletter.toJson(), db);
      subject.add(List.unmodifiable([...subject.value, newsletter]));
    } finally {
      await db.close();
    }
  }

  @override
  Stream<List<NewsletterLocal>> getNewsletterStream() {
    return subject.stream;
  }
}
