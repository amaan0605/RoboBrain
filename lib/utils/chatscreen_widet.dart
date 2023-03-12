import 'package:ai_magic/utils/constants.dart';
import 'package:flutter/material.dart';
import '../models/chat_model.dart';

class ChatScreenWidget extends StatelessWidget {
  const ChatScreenWidget(
      {super.key,
      required this.message,
      required this.chatMessageType,
      required this.userName,
      required this.userNumber});

  final String message;
  final ChatMessageType chatMessageType;
  final String userName;
  final int userNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: chatMessageType == ChatMessageType.user
            ? pinkBubbleColor
            : const Color.fromARGB(255, 229, 231, 235),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(12),
          topRight: const Radius.circular(12),
          bottomLeft: chatMessageType == ChatMessageType.user
              ? const Radius.circular(12)
              : const Radius.circular(0),
          bottomRight: chatMessageType == ChatMessageType.user
              ? const Radius.circular(0)
              : const Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: chatMessageType == ChatMessageType.user
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (chatMessageType != ChatMessageType.user)
            const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/bot.png'),
            ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: chatMessageType == ChatMessageType.user
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  chatMessageType == ChatMessageType.user
                      ? userName
                      : 'RoboBrain',
                  style: const TextStyle(
                    color: botBackgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    color: backgroundColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (chatMessageType == ChatMessageType.user)
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/avatars/256_$userNumber.png'),
            ),
        ],
      ),
    );
  }
}
