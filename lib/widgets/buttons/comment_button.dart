import 'package:flutter/material.dart';

class CommentButton extends StatelessWidget {
  const CommentButton(this.comments, {super.key});
  final List<String> comments;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final commentController = TextEditingController();

        showDialog<void>(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Comments'),
              content: StatefulBuilder(
                builder: (context, setState) {
                  return SizedBox(
                    width: 500,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (comments.isEmpty) const Text('No comments yet'),
                        for (final comment in comments)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: Text(comment),
                            ),
                          ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: commentController,
                                decoration: const InputDecoration(
                                  labelText: 'Add comment',
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                final text = commentController.text.trim();
                                if (text.isEmpty) return;
                                setState(() {
                                  comments.add(text);
                                });
                                commentController.clear();
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
      child: const Text('add comment'),
    );
  }
}
