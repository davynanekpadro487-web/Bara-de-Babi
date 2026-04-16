/// Modèle Message — conforme UML Barra de Babi
class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String receiverId;
  final String contenu;
  final bool estLu;
  final DateTime envoyeLe;
  final DateTime? luLe;

  const MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.contenu,
    this.estLu = false,
    required this.envoyeLe,
    this.luLe,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      conversationId: json['conversationId'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      contenu: json['content'] ?? json['contenu'] ?? '',
      estLu: json['isRead'] ?? json['est_lu'] ?? false,
      envoyeLe:
          DateTime.tryParse(json['timestamp'] ?? json['envoye_le'] ?? '') ??
          DateTime.now(),
      luLe: json['lu_le'] != null ? DateTime.tryParse(json['lu_le']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'conversationId': conversationId,
    'senderId': senderId,
    'receiverId': receiverId,
    'content': contenu,
    'isRead': estLu,
    'timestamp': envoyeLe.toIso8601String(),
  };
}

/// Modèle Conversation
class ConversationModel {
  final String id;
  final String userId;
  final String artisanId;
  final String artisanName;
  final String? artisanJob;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;

  const ConversationModel({
    required this.id,
    required this.userId,
    required this.artisanId,
    required this.artisanName,
    this.artisanJob,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount = 0,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      artisanId: json['artisanId'] ?? '',
      artisanName: json['artisanName'] ?? '',
      artisanJob: json['artisanJob'],
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'] != null
          ? DateTime.tryParse(json['lastMessageTime'])
          : null,
      unreadCount: json['unreadCount'] ?? 0,
    );
  }
}
