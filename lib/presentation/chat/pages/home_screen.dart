import 'package:fire_chat/models/message.dart';
import 'package:fire_chat/presentation/chat/cubit/chat_cubit.dart';
import 'package:fire_chat/presentation/chat/widgets/message_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final chatCubit = ChatCubit();
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    chatCubit.getMessages();
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Chat"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: BlocBuilder<ChatCubit, ChatState>(
                    bloc: chatCubit,
                    builder: (context, state) {
                      var chatState = state;
                      if (chatState is ChatLoaded) {
                        return ListView.separated(
                            controller: _scrollController,
                            itemBuilder: (ctx, idx) => MessageWidget(
                                isMe: chatState.messages[idx].sender ==
                                    chatCubit.currentUser,
                                message: chatState.messages[idx]),
                            separatorBuilder: (_, __) => SizedBox(
                                  height: 10,
                                ),
                            itemCount: chatState.messages.length);
                      } else if (chatState is ChatError) {
                        return Center(
                          child: Text(chatState.error),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          ChatCubit().sendMessage(_messageController.text);
                          _messageController.clear();
                          _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent);
                        },
                        icon: Icon(Icons.send)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
