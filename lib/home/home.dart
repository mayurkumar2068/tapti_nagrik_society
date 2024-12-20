import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tapti_nagrik_society/authentication/sidemenu/sidemenu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' as excel;
import 'package:flutter/foundation.dart';
import 'package:tapti_nagrik_society/home/add_user.dart';
import 'package:tapti_nagrik_society/home/dds.dart';
import 'package:tapti_nagrik_society/home/rd.dart';
import 'package:tapti_nagrik_society/home/saving.dart';
import 'fd.dart';
import 'mis.dart'; // For kIsWeb

final GlobalKey<HomeViewState> homeViewKey = GlobalKey<HomeViewState>();

class HomeView extends StatefulWidget {
  final String title;
  HomeView({Key? key, required this.title}) : super(key: homeViewKey);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _selectedIndex = 0;
  List<List<String>> excelData = [];
  String adminName = "Kamlesh Dahare";

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
    final width = MediaQuery.of(context).size.width;
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
        return Container(
          height: width * 0.35,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 4),
                  Text(
                    "Choose service type ",
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Saving()));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Colors.deepPurple,
                          ),
                          child: Text('DDS', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(width: 2),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Colors.green,
                          ),
                          child: Text('RD', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(width: 2),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Colors.indigo,
                          ),
                          child: Text('FD', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(width: 2),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Colors.deepOrangeAccent,
                          ),
                          child: Text('MIS', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.indigo.shade200, width: 1),
              ),
            ),
          ),
        );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          onPressed: toggleDrawer,
          icon: Icon(Icons.menu, color: Colors.white, size: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddUserView()));
            },
            icon: Icon(Icons.person_add_rounded, color: Colors.white, size: 20),
          ),
        ],
      ),
      drawer: SideMenu(),
      body: Stack(
        children: [
          _getBody(), // The main content
          SlideTransition(
            position: Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0)).animate(_controller),
            child: Container(
              color: Colors.white, // Ensures the background remains white when sliding
              child: SideMenu(),
            ),
          ),
        ],
      ),
    );
  }

}
