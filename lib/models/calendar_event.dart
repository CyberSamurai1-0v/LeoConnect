import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class CalendarEvent {
  final String title;
  final DateTime date;
  final String description;
  final String location;

  CalendarEvent({
    required this.title,
    required this.date,
    required this.description,
    required this.location,
  });

  // Factory constructor to convert JSON to Calendar Event
  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      title: json['title'],
      date: DateTime.parse(json['event_date']), // parse string to DateTime
      description: json['description'],
      location: json['location'],
    );
  }

  String get formattedDate {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  static Future<List<CalendarEvent>> fetchEvents() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/api/events'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => CalendarEvent.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch events');
    }
  }
}
