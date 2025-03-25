import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final _auth = FirebaseAuth.instance;
  String get currentUser => _auth.currentUser!.email!;
  final _storage = FirebaseFirestore.instance;
  var messages = List<Message>.empty();

  void getMessages() {
    emit(ChatLoading());
    try {
      _storage
          .collection("chats")
          .doc("group_chat")
          .collection("messages")
          .orderBy("time", descending: false)
          .snapshots()
          .listen((event) {
        messages = event.docs.map((e) => Message.fromJson(e.data())).toList();
        emit(ChatLoaded(messages: messages));

        //  emit(ChatLoaded(messages: messages));
      });
    } on FirebaseException catch (e) {
      emit(ChatError(error: e.message!));
    }
  }

  void sendMessage(String message) {
    _storage.collection("chats").doc("group_chat").collection("messages").add({
      "message": message,
      "sender": _auth.currentUser!.email,
      "time": DateTime.now().toIso8601String()
    });
  }
}
