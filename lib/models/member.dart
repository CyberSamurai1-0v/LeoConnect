import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class Member {
  final String name;
  final String club;
  final String role;
  final String avatarUrl;

  Member({
    required this.name,
    required this.club,
    required this.role,
    required this.avatarUrl,
  });

  // Factory constructor to convert JSON to Member
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'],
      club: json['club'],
      role: json['role'],
      avatarUrl: json['avatarurl'] ?? '', // fallback if null
    );
  }

  // Fetch members from backend
  static Future<List<Member>> fetchAllMembers() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/api/users'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Member.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}
