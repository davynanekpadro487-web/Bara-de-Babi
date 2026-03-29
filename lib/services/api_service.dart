import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../models/user_model.dart';
import '../models/message_model.dart';

/// Service API — Communication avec le backend Node.js
class ApiService {
  static const String _baseUrl = AppConstants.baseUrl;

  // ─── Health Check ─────────────────────────────────
  static Future<bool> healthCheck() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/health'));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // ─── Users ────────────────────────────────────────
  static Future<List<UserModel>> getArtisans() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/prestataires'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => UserModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<UserModel?> getUser(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users/$id'));
      if (response.statusCode == 200) {
        return UserModel.fromJson(json.decode(response.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // ─── Conversations ────────────────────────────────
  static Future<ConversationModel?> createConversation({
    required String userId,
    required String artisanId,
    required String artisanName,
    String? artisanJob,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/conversations'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': userId,
          'artisanId': artisanId,
          'artisanName': artisanName,
          'artisanJob': artisanJob,
        }),
      );
      if (response.statusCode == 201) {
        return ConversationModel.fromJson(json.decode(response.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List<ConversationModel>> getConversations(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/conversations/user/$userId'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((j) => ConversationModel.fromJson(j)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // ─── Messages ─────────────────────────────────────
  static Future<MessageModel?> sendMessage({
    required String conversationId,
    required String senderId,
    required String receiverId,
    required String content,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/messages'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'conversationId': conversationId,
          'senderId': senderId,
          'receiverId': receiverId,
          'content': content,
        }),
      );
      if (response.statusCode == 201) {
        return MessageModel.fromJson(json.decode(response.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List<MessageModel>> getMessages(String conversationId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/messages/conversation/$conversationId'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((j) => MessageModel.fromJson(j)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // ─── Payments ─────────────────────────────────────
  static Future<Map<String, dynamic>?> createPayment({
    required String userId,
    required String artisanId,
    required double amount,
    required String method,
    required String phoneNumber,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/payments'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': userId,
          'artisanId': artisanId,
          'amount': amount,
          'method': method,
          'phoneNumber': phoneNumber,
        }),
      );
      if (response.statusCode == 201) {
        return json.decode(response.body);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
