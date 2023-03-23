import 'package:flutter/material.dart';
import 'package:your_tours_mobile/models/responses/user_response.dart';

class ProfileInformation extends StatefulWidget {
  final UserInfo userInfo;

  const ProfileInformation({Key? key, required this.userInfo})
      : super(key: key);

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text(
            'Họ và tên:',
          ),
          subtitle: Text(widget.userInfo.fullName ?? ''),
        ),
        ListTile(
          title: const Text(
            'Email:',
          ),
          subtitle: Text(widget.userInfo.email ?? ''),
        ),
      ],
    );
  }
}
