import 'package:ai_magic/models/chat_model.dart';
import 'package:ai_magic/services/api/api_chat.dart';
import 'package:ai_magic/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils/chatscreen_widet.dart';
import '../utils/widgets.dart';

class ChatScreen extends StatefulWidget {
  final int number;
  final String userName;
  const ChatScreen({super.key, required this.number, required this.userName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController chatController = TextEditingController();
  List<ChatMessage> messages = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   CircleAvatar(
        //       backgroundImage:
        //           AssetImage('assets/avatars/256_${widget.number + 1}.png')),
        //   const SizedBox(width: 15),
        // ],
        elevation: 0,
        title: const Text('RoboBrain'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: ((context, index) {
                var mes = messages[index];
                return ChatScreenWidget(
                  userName: widget.userName,
                  userNumber: widget.number,
                  message: mes.text,
                  chatMessageType: mes.chatMessageType,
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: backgroundColor),
              child: isLoading
                  ? SizedBox(
                      height: 50,
                      child: SpinKitWave(
                        size: 30,
                        color: Colors.grey.shade300,
                      ))
                  : Row(
                      children: [
                        textFormField(chatController),
                        InkWell(
                          onTap: () async {
                            if (chatController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: backgroundColor,
                                  content: Text('Please type something...'),
                                ),
                              );
                              return;
                            }
                            setState(() {
                              isLoading = true;
                              messages.add(
                                ChatMessage(
                                  text: chatController.text,
                                  chatMessageType: ChatMessageType.user,
                                ),
                              );
                            });
                            await generateChatResponse(chatController.text)
                                .then((value) {
                              setState(() {
                                isLoading = false;
                                messages.add(ChatMessage(
                                    text: value,
                                    chatMessageType: ChatMessageType.bot));
                                scrollListToEnd();
                              });
                            });

                            chatController.clear();
                          },
                          child: const Icon(
                            Icons.send,
                            color: botBackgroundColor,
                          ),
                        )
                      ],
                    ),
            ),
          )
        ],
      )),
    );
  }

  void scrollListToEnd() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }
}
