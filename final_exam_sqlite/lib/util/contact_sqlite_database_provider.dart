import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:finalexam202301_seokhyeon_201914068/model/contact.dart';

class ContactSQLiteDatabaseProvider{
  static const String DATABASE_FILENAME = 'contact_database.db';
  static const String CONTACTS_TABLENAME = 'contacts';

  static ContactSQLiteDatabaseProvider databaseProvider = ContactSQLiteDatabaseProvider._();
  static Database? database;
  ContactSQLiteDatabaseProvider._();

  static ContactSQLiteDatabaseProvider getDatabaseProvider() => databaseProvider;

  Future<Database> _getDatabase() async {
    return database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(),DATABASE_FILENAME),
      version: 1,
      onCreate: (db,version){
        return db.execute('CREATE TABLE $CONTACTS_TABLENAME(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, address TEXT, phoneNumber TEXT)');
      }
    );
  }

  Future<void> insertContact(Contact contact) async {
    Database database = await _getDatabase();
    database.insert(CONTACTS_TABLENAME, contact.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Contact>> getContacts() async {
    Database database = await _getDatabase();
    var maps = await database.query(CONTACTS_TABLENAME);
    List<Contact> contactList = List.empty(growable: true);
    for(Map<String, dynamic>map in maps){
      contactList.add(Contact.fromMap(map));
    }
    return contactList;
  }

  Future<void> updateContact(Contact contact) async {
    Database database = await _getDatabase();
    database.update(CONTACTS_TABLENAME, contact.toMap(), where: 'id=?', whereArgs: [contact.id]);
  }

  Future<void> deleteContact(Contact contact) async {
    Database database = await _getDatabase();
    database.delete(CONTACTS_TABLENAME,  where: 'id=?', whereArgs: [contact.id]);
  }



}