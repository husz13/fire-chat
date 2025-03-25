class Message {
  final String message;
  final String sender;
  final DateTime time;

  Message({required this.message, required this.sender, required this.time});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        message: json['message'],
        sender: json['sender'],
        time: DateTime.parse(json['time']));
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sender': sender,
      'time': time.toIso8601String()
    };
  }
}
