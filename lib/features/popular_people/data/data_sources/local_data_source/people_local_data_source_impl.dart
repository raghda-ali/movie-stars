import 'package:movie_stars/features/popular_people/data/data_sources/local_data_source/people_local_data_source.dart';
import 'package:movie_stars/features/popular_people/data/models/person_model.dart';
import 'package:movie_stars/features/popular_people/data/models/person_response_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PeopleLocalDataSourceImpl implements PeopleLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'people_v2.db');
    _database = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE people (
            id INTEGER PRIMARY KEY,
            name TEXT,
            profilePath TEXT,
            knownForDepartment TEXT,
            popularity REAL,
            biography TEXT,
            birthday TEXT,
            deathDay TEXT,
            placeOfBirth TEXT,
            alsoKnownAs TEXT,
            page INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE metadata (
            key TEXT PRIMARY KEY,
            value TEXT
          )
        ''');
      },
    );
    return _database!;
  }

  @override
  Future<void> cachePopularPeople(PersonResponseModel people, int page) async {
    final db = await database;
    await db.delete('people', where: 'page = ?', whereArgs: [page]);

    final batch = db.batch();
    for (var person in people.results) {
      batch.insert('people', person.toMap()..['page'] = page);
    }

    batch.insert('metadata', {
      'key': 'lastCachedPage',
      'value': page.toString(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    await batch.commit(noResult: true);
  }

  @override
  Future<PersonResponseModel> getCachedPopularPeople(int page) async {
    final db = await database;
    final maps = await db.query('people', where: 'page = ?', whereArgs: [page]);
    final people = maps.map((e) => PersonModel.fromMap(e)).toList();
    return PersonResponseModel(page: page, results: people, totalPages: 500);
  }

  @override
  Future<int> getLastCachedPage() async {
    final db = await database;
    final result = await db.query(
      'metadata',
      where: 'key = ?',
      whereArgs: ['lastCachedPage'],
    );

    if (result.isNotEmpty) {
      return int.tryParse(result.first['value'] as String) ?? 1;
    } else {
      return 1;
    }
  }
}
