import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tapti_nagrik_society/authentication/sidemenu/sidemenu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' as excel;
import 'package:flutter/foundation.dart';
import 'package:tapti_nagrik_society/database/database.dart';


import 'home.dart'; // For kIsWeb

class DDSView extends StatefulWidget {
  final String title;
  DDSView({Key? key, required this.title}) : super();

  @override
  DDSViewState createState() => DDSViewState();
}

class DDSViewState extends State<DDSView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _selectedIndex = 0;
  List<List<String>> excelData = [];
  List<Member> filteredData = [];
  TextEditingController searchController = TextEditingController();
  List<UserDetails> users = [];
  List<Member> members = [];
  Map<String,dynamic> data = {};

  Widget buildUserCell(Member user) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          child: Text(data['fullName']),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        title: Text("DDS Data", style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Father's Name: ${user.fathername}"),
            Text("Mobile: ${user.mobileNo}"),
            Text("Ansh Amount: ₹${user.anshAmount}"),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.deepPurple),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
   _showAllData();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    searchController.dispose();
    super.dispose();
  }

  // Future<void> _fetchMembers() async {
  //   try {
  //     final dbMembers = await DatabaseHelper.instance.getAllMembers();
  //     setState(() {
  //       members = dbMembers;
  //     });
  //     print("Members data    $members");
  //   } catch (e) {
  //     print("Error fetching members: $e");
  //   }
  // }
  Future<void> _showAllData() async {
    try {
      final db = await DatabaseHelper.instance.database;

      final List<Map<String, dynamic>> result = await db.query('members'); // Fetch data

      for (var row in result) {
        setState(() {
          data = row;
        });
        print("map data $data");
        print("row data is here ------------$row"); // Print each row
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _pickAndReadExcel() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );

      if (result != null) {
        final List<Member> tempData = [];
        if (kIsWeb) {
          var bytes = result.files.single.bytes!;
          var excelFile = excel.Excel.decodeBytes(bytes);
          //tempData.addAll(_parseExcelData(excelFile));
        } else {
          var bytes = File(result.files.single.path!).readAsBytesSync();
          var excelFile = excel.Excel.decodeBytes(bytes);
          //tempData.addAll(_parseExcelData(excelFile));
        }

        setState(() {
       //   excelData = tempData;
          filteredData = tempData; // Initialize filtered data with all data
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  List<List<String>> _parseExcelData(excel.Excel excelFile) {
    final List<List<String>> parsedData = [];
    for (var table in excelFile.tables.keys) {
      for (var row in excelFile.tables[table]!.rows) {
        parsedData.add(row.map((cell) => cell?.value.toString() ?? "").toList());
      }
      break; // Only process the first table
    }
    return parsedData;
  }

  void _filterExcelData(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredData = List.from(members);
      } else {
        filteredData = members.where((member) {
          return member.fullname.toLowerCase().contains(query.toLowerCase()) ||
              member.mobileNo.toLowerCase().contains(query.toLowerCase()) ||
              member.fathername.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }


  Widget _buildExcelViewer() {
    if (data.isEmpty) {
      return Center(child: Text("No Data Available"));
    }

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: data.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index)  {
              return buildUserCell(data[index]);
              }
        )
      ),
    );
  }


  Widget _getBody() {
    switch (widget.title) {
      case "Daily Saving Scheme":
      case "FD":
      case "MIS":
        return Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                onChanged: _filterExcelData,
                decoration: InputDecoration(
                  hintText: "Enter Search Id",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: _pickAndReadExcel,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  backgroundColor: Colors.deepPurple,
                ),
                child: Text('Upload Excel', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              _buildExcelViewer(),
            ],
          ),
        );
      default:
        return Center(child: Text(widget.title, style: TextStyle(fontSize: 24)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView(title: "Home View")));
          },
          icon: Icon(Icons.arrow_circle_left, color: Colors.white, size: 20),
        ),
      ),
      drawer: SideMenu(),
      body: Stack(
        children: [
          SlideTransition(
            position: Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0)).animate(_controller),
            child: SideMenu(),
          ),
          _getBody(),
        ],
      ),
    );
  }
}
class UserDetails {
  final String fullname;
  final String fathername;
  final String husbandname;
  final String adharno;
  final String nomineename;
  final String mobileno;
  final String address;
  final String openingdate;
  final String dateofbirth;
  final String ansh;
  final String anshamt;
  final String entryFees;
  final String memberId;

  UserDetails({
    required this.fullname,
    required this.fathername,
    required this.husbandname,
    required this.adharno,
    required this.nomineename,
    required this.mobileno,
    required this.address,
    required this.openingdate,
    required this.dateofbirth,
    required this.ansh,
    required this.anshamt,
    required this.entryFees,
    required this.memberId,
  });
}
