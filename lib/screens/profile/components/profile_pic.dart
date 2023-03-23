import 'package:flutter/material.dart';

class ProfilePic extends StatefulWidget {
  final String? avatar;

  const ProfilePic({Key? key, this.avatar}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          widget.avatar != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(widget.avatar!),
                )
              : const CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/Profile Image.png"),
                ),
        ],
      ),
    );
  }
}
