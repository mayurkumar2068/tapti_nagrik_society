import 'package:flutter/material.dart';


import '../../home/dds.dart';
import '../../home/fd.dart';
import '../../home/home.dart';
import '../../home/mis.dart';
import '../../home/rd.dart';
import 'menuservice.dart';

class SideMenu extends StatefulWidget {
  @override
  _CustomSideMenuState createState() => _CustomSideMenuState();
}

class _CustomSideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isWeb = screenWidth > 600;

    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white, // Solid white background for Drawer
        child: Container(
          width: isWeb ? screenWidth * 0.25 : screenWidth * 0.75, // Adjust width for web/mobile
          color: Colors.white, // Solid white background for Container
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        homeViewKey.currentState?.toggleDrawer(); // Close the side menu
                      },
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                    Spacer(),
                    Text(
                      'Services',
                      style: TextStyle(
                        fontSize: isWeb ? 24 : 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              // Profile Section
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white, // Ensure no transparency
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: isWeb ? 30 : 20,
                      backgroundImage: AssetImage("assets/image/splash.png"),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Manager",
                          style: TextStyle(
                            fontSize: isWeb ? 18 : 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "Kamlesh Dahare",
                          style: TextStyle(
                            fontSize: isWeb ? 20 : 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Menu Items
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    _buildMenuItem(Icons.dashboard, "DDS", isWeb),
                    _buildMenuItem(Icons.save, "RD", isWeb),
                    _buildMenuItem(Icons.account_balance, "FD", isWeb),
                    _buildMenuItem(Icons.timer, "MIS", isWeb),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, bool isWeb) {
    return ListTile(
      leading: Icon(icon, size: isWeb ? 28 : 24, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(fontSize: isWeb ? 18 : 16, color: Colors.black),
      ),
      onTap: () {
        if (title == "DDS") {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DDSView(title: "Daily Saving Scheme")));
          homeViewKey.currentState?.toggleDrawer();
        } else if (title == "RD") {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RDView(title: "RD")));
          homeViewKey.currentState?.toggleDrawer();
        } else if (title == "FD") {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FDView(title: "FD")));
          homeViewKey.currentState?.toggleDrawer();
        } else if (title == "MIS") {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MISView(title: "MIS")));
          homeViewKey.currentState?.toggleDrawer();
        }
      },
    );
  }
}
