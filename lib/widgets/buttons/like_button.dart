import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  LikeButton(this.liked, {super.key});
  bool liked;
  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (widget.liked) {
          setState(() {
            widget.liked = false;
          });
        } else {
          setState(() {
            widget.liked = true;
          });
        }
      },
      icon: widget.liked ? Icon(Icons.favorite) : Icon(Icons.favorite_outline),
    );
  }
}
