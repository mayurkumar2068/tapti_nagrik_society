import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import '../popup/popup.dart';

class DatabaseService {
  static Future<MySqlConnection?> connect() async {
    try {
      final conn = await MySqlConnection.connect(
        ConnectionSettings(
          host: 'localhost',
          port: 3306,
          user: 'root',
         //password: 'Mayur@8665', // MySQL password
          db: 'TAPTI_NAGRIK', // Your database name
        ),
      );
      print('Database connection successful');
      return conn;
    } catch (e) {
      debugPrint('Database connection failed: $e');
      return null; // Return null if connection fails
    }
  }

  /// Insert user details and show a popup
  static Future<void> insertUserDetails({
    required BuildContext context,
    required String fullname,
    required String fathername,
    required String husbandname,
    required int adharno,
    required String nomineename,
    required int mobileno,
    required String address,
    required String openingdate,
    required String dateofbirth,
    required int ansh,
    required int anshamt,
    required int entryFees,
    required String memberId,
  }) async {
    final conn = await connect();
    if (conn == null) {
      // Show error popup if connection fails
      _showErrorPopup(
        context,
        'Connection Error',
        'Failed to connect to the database. Please try again.',
      );
      return;
    }

    try {
      await conn.query(
        '''
        INSERT INTO add_user (
          fullname, fathername, husbandname, adharno, nomineename, mobileno, address, 
          openingdate, dateofbirth, ansh, anshamt, entry_fees, memberId
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''',
        [
          fullname,
          fathername,
          husbandname,
          adharno,
          nomineename,
          mobileno,
          address,
          openingdate,
          dateofbirth,
          ansh,
          anshamt,
          entryFees,
          memberId,
        ],
      );
      debugPrint('User inserted successfully');
      _showSuccessPopup(context);
    } catch (e) {
      debugPrint('Error inserting user: $e');
      _showErrorPopup(
        context,
        'Insert Error',
        'Failed to save user details: $e',
      );
    } finally {
      await conn.close();
    }
  }

  /// Show success popup
  static void _showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopup(
          title: "Success",
          description: "User details saved successfully!",
          buttonText: "Okay",
          onButtonPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  /// Show error popup
  static void _showErrorPopup(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopup(
          title: title,
          description: description,
          buttonText: "Retry",
          onButtonPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
