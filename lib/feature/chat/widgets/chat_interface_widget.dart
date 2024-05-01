
import 'package:brainify/core/config/type_of_message.dart';
import 'package:brainify/core/extension/context.dart';
import 'package:brainify/feature/chat/provider/message_provider.dart';
import 'package:brainify/feature/hive/model/chat_bot/chat_bot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatInterfaceWidget extends ConsumerWidget {
  const ChatInterfaceWidget({
    required this.messages,
    required this.chatBot,
    required this.color,
    required this.imagePath,
    super.key,
  });

  final List<types.Message> messages;
  final ChatBot chatBot;
  final Color color;
  final String imagePath;

  Color _getAdjustedColor(BuildContext context) {
    return Theme.of(context).brightness == 
    Brightness.dark ? color.withOpacity(0.7) : color;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color adjustedColor = _getAdjustedColor(context);
    // ignore: non_constant_identifier_names
    final Color InputTextColor = 
      Theme.of(context).brightness == Brightness.light
        ? Colors.indigo 
        : Colors.pink.shade50; 
    return Chat(
      messages: messages,
      onSendPressed: (text) =>
          ref.watch(messageListProvider.notifier).handleSendPressed(
                text: text.text,
                imageFilePath: chatBot.attachmentPath,
              ),
      user: const types.User(id: TypeOfMessage.user),
      showUserAvatars: true,
      avatarBuilder: (user) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: CircleAvatar(
          backgroundColor: adjustedColor,
          radius: 19,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              imagePath,
              color: context.colorScheme.surface,
            ),
          ),
        ),
      ),
      theme: DefaultChatTheme(
        backgroundColor: Colors.transparent,
        primaryColor: context.colorScheme.onSurfaceVariant,
        secondaryColor: color,
        inputBackgroundColor: context.colorScheme.onSurfaceVariant,
        inputTextColor:InputTextColor,

        sendingIcon: Icon(
          Icons.send,
          color: context.colorScheme.onSurface,

        ),
        inputTextCursorColor: context.colorScheme.onSurface,
        receivedMessageBodyTextStyle: TextStyle(
          color: context.colorScheme.onBackground,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        sentMessageBodyTextStyle: const TextStyle(
          color: Color(0xFF435D6A),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        dateDividerTextStyle: TextStyle(
          color: context.colorScheme.onPrimaryContainer,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          height: 1.333,
        ),
        inputTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.5,
          color:Colors.purple,

        ),
        inputTextDecoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isCollapsed: true,
          fillColor: context.colorScheme.background,
        ),
        inputBorderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }
}
