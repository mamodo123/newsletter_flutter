abstract class SQLiteConfig {
  static const dbPath = 'newsletter.db';
  static const dbVersion = 1;

  static const List<String> onCreate = [
    """CREATE TABLE Newsletter (
      title TEXT NOT NULL,
      category TEXT NOT NULL,
      summary TEXT NOT NULL,
      link TEXT NOT NULL,
      createdAt DATETIME NOT NULL,
      uuid TEXT NOT NULL PRIMARY KEY,
      remote TEXT
    );"""
  ];
}
