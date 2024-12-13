abstract class SQLiteConfig {
  static const dbPath = 'newsletter.db';
  static const dbVersion = 1;

  static const List<String> onCreate = [
    """CREATE TABLE Newsletter (
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      category TEXT NOT NULL,
      summary TEXT NOT NULL,
      link TEXT NOT NULL,
      createdAt DATETIME NOT NULL,
      uuid TEXT NOT NULL,
      remote TEXT
    );"""
  ];
}
