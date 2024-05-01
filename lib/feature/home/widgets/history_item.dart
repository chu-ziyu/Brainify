import 'package:brainify/core/extension/context.dart';
import 'package:brainify/core/navigation/route.dart';
import 'package:brainify/feature/chat/provider/message_provider.dart';
import 'package:brainify/feature/hive/model/chat_bot/chat_bot.dart';
import 'package:brainify/feature/home/provider/chat_bot_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryItem extends ConsumerWidget {
  const HistoryItem({
    required this.label,
    required this.imagePath,
    required this.color,
    required this.chatBot,
    super.key,
  });
  final String label;
  final String imagePath;
  final Color color;
  final ChatBot chatBot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color backgroundColor = 
      Theme.of(context).brightness == Brightness.light
        ? const Color(0xFFF1E9F2) 
        : context.colorScheme.surfaceTint; 

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: DecoratedBox(
        decoration: BoxDecoration(
        boxShadow:[
          BoxShadow(
            color: Colors.white.withOpacity(0.25),
            offset: const Offset(4, 4),
            blurRadius: 8,
           ),
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      child:ElevatedButton(
        onPressed: () {
          ref.read(messageListProvider.notifier).updateChatBot(chatBot);
          AppRoute.chat.push(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, 
          foregroundColor: color,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  imagePath,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium!.copyWith(
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.95),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: context.colorScheme.onSurface,
              ),
              onPressed: () {
                ref.read(chatBotListProvider.notifier).deleteChatBot(chatBot);
              },
            ),
          ],
        ),
      ),
      ), 
    );
  }
}
