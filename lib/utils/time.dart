import 'package:cloud_firestore/cloud_firestore.dart';

class Time {
  static String getGreetingMessages() {
    DateTime _data = DateTime.now();
    int _currentHour = _data.hour;
    if (_currentHour >= 6 && _currentHour < 12) {
      return 'Good Morning!';
    } else if (_currentHour >= 12 && _currentHour < 18) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  static Timestamp getTimeStamps() {
    return Timestamp.now();
  }

  static String convertToDate(Timestamp timestamp) {
    DateTime data = timestamp.toDate();
    return '${data.day} - ${data.month} - ${data.year}';
  }
}
