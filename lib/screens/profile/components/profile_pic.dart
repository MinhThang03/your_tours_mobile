import 'package:flutter/material.dart';
import 'package:your_tours_mobile/constants.dart';

class ProfilePic extends StatefulWidget {
  final String? avatar;

  const ProfilePic({Key? key, this.avatar}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(18.0)),
      child: Container(
        padding: const EdgeInsets.all(1),
        color: kPrimaryColor,
        child: Image.network(
          widget.avatar != null
              ? widget.avatar!
              : "https://static.vecteezy.com/system/resources/thumbnails/002/002/403/small/man-with-beard-avatar-character-isolated-icon-free-vector.jpg",
          fit: BoxFit.cover,
          height: 50,
          width: 50,
        ),
      ),
    );
  }
}
