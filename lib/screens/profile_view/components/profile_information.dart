import 'package:flutter/material.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({Key? key}) : super(key: key);

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'Họ và tên:',
          ),
          subtitle: Text('Hoàng Minh Thắng'),
        ),
        ListTile(
          title: Text(
            'Họ và tên:',
          ),
          subtitle: Text('Hoàng Minh Thắng'),
        ),
      ],
    );
  }
}
