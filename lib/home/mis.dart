
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tapti_nagrik_society/authentication/sidemenu/sidemenu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' as excel;
import 'package:flutter/foundation.dart';

import 'home.dart'; // For kIsWeb

class MISView extends StatefulWidget {
  final String title;
  MISView({Key? key, required this.title}) : super();

  @override
  MISViewState createState() => MISViewState();
}

class MISViewState extends State<MISView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _selectedIndex = 0;
  List<List<String>> excelData = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void toggleDrawer() {
    if (_controller.isCompleted) {
      _controller.reverse(); // Close the drawer
    } else {
      _controller.forward(); // Open the drawer
    }
  }

  Future<void> _pickAndReadExcel() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );

      if (result != null) {
        final List<List<String>> tempData = [];
        if (kIsWeb) {
          var bytes = result.files.single.bytes!;
          var excelFile = excel.Excel.decodeBytes(bytes);
          tempData.addAll(_parseExcelData(excelFile));
        } else {
          var bytes = File(result.files.single.path!).readAsBytesSync();
          var excelFile = excel.Excel.decodeBytes(bytes);
          tempData.addAll(_parseExcelData(excelFile));
        }

        setState(() {
          excelData = tempData;
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

  Widget _buildExcelViewer() {
    if (excelData.isEmpty) {
      return Center(child: Text("No Data Available"));
    }

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
          border: TableBorder.all(color: Colors.grey.shade400),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: excelData.map((row) {
            return TableRow(
              children: row.map((cell) {
                return Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    cell,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ),
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
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeView(title: "Home View")));
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