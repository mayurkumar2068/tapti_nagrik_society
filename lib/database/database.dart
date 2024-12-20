import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('members.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE members (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullname TEXT,
        fathername TEXT,
        husbandname TEXT,
        adharNumber TEXT,
        nomineeName TEXT,
        mobileNo TEXT,
        address TEXT,
        openingDate TEXT,
        ansh TEXT,
        anshAmount TEXT,
        entryFee TEXT,
        dateOfBirth TEXT,
        memberId TEXT
      )
    ''');
  }

  Future<void> _showAllData() async {
    try {
      final db = await DatabaseHelper.instance.database;

      final List<Map<String, dynamic>> result = await db.query('members'); // Fetch data
      for (var row in result) {
        print("row data is here ------------$row"); // Print each row
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }



  Future<int> insertMember(Member member) async {
    final db = await database;

    return await db.insert('members', member.toMap());
  }

  void _fetchMembers() async {
    final dbHelper = DatabaseHelper.instance;

    final members = await dbHelper.getAllMembers();

    for (var member in members) {
      print("Member: ${member.fullname}, Mobile: ${member.mobileNo}");
    }
  }

  Future<int> updateMember(Member member) async {
    final db = await instance.database;
    return await db.update(
      'members',
      member.toMap(),
      where: 'id = ?',
      whereArgs: [member.id],
    );
  }

  Future<List<Member>> getAllMembers() async {
    final db = await database;
    _showAllData();
    print(db.rawQuery('SELECT * FROM members'));
    final result = await db.query('members');
    return result.map((json) => Member.fromMap(json)).toList();
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}

class Member {
  final int? id;
  final String fullname;
  final String fathername;
  final String husbandname;
  final String adharNumber;
  final String nomineeName;
  final String mobileNo;
  final String address;
  final String openingDate;
  final String ansh;
  final String anshAmount;
  final String entryFee;
  final String dateOfBirth;
  final String memberId;

  Member({
    this.id,
    required this.fullname,
    required this.fathername,
    required this.husbandname,
    required this.adharNumber,
    required this.nomineeName,
    required this.mobileNo,
    required this.address,
    required this.openingDate,
    required this.ansh,
    required this.anshAmount,
    required this.entryFee,
    required this.dateOfBirth,
    required this.memberId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'fathername': fathername,
      'husbandname': husbandname,
      'adharNumber': adharNumber,
      'nomineeName': nomineeName,
      'mobileNo': mobileNo,
      'address': address,
      'openingDate': openingDate,
      'ansh': ansh,
      'anshAmount': anshAmount,
      'entryFee': entryFee,
      'dateOfBirth': dateOfBirth,
      'memberId': memberId,
    };
  }

  static Member fromMap(Map<String, dynamic> map) {
    return Member(
      id: map['id'],
      fullname: map['fullname'],
      fathername: map['fathername'],
      husbandname: map['husbandname'],
      adharNumber: map['adharNumber'],
      nomineeName: map['nomineeName'],
      mobileNo: map['mobileNo'],
      address: map['address'],
      openingDate: map['openingDate'],
      ansh: map['ansh'],
      anshAmount: map['anshAmount'],
      entryFee: map['entryFee'],
      dateOfBirth: map['dateOfBirth'],
      memberId: map['memberId'],
    );
  }
}
