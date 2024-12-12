import 'dart:async';

import 'package:newsletter/src/core/helper/db_helper.dart';
import 'package:newsletter/src/data/models/newsletter/newsletter_local.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/config/db_config.dart';
import 'newsletter_service_local.dart';

class NewsletterServiceSqlite extends NewsletterServiceLocal {
  static const table = 'Newsletter';

  NewsletterServiceSqlite()
      : super(BehaviorSubject<List<NewsletterLocal>>.seeded([])) {
    loadNewsletters();
  }

  Future<void> loadNewsletters() async {
    final db = await DBHelper.getDatabase(
        DBConfig.dbPath, DBConfig.dbVersion, DBConfig.onCreate);
    final newsletterDBReturn =
        await DBHelper.runSelectSql('select * from $table', db, []);
    final newsletterMap = newsletterDBReturn
        .map((e) => NewsletterLocal.fromJson(json: e))
        .toList();
    subject.add(newsletterMap);
  }

  @override
  Future<void> addNewsletter(NewsletterLocal newsletter) async {
    final db = await DBHelper.getDatabase(
        DBConfig.dbPath, DBConfig.dbVersion, DBConfig.onCreate);
    try {
      await DBHelper.runInsertSql(table, newsletter.toJson(), db);
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
