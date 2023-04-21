import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/controllers/user_controller.dart';
import 'package:your_tours_mobile/models/responses/user_response.dart';

import 'profile_pic.dart';

class ProfileInfoSection extends StatelessWidget {
  ProfileInfoSection({
    Key? key,
  }) : super(key: key);

  UserController userController = Get.find<UserController>();

  bool _getStatusOfUser(UserInfo? userInfo) {
    if (userInfo == null) {
      return false;
    }

    if (userInfo.status == 'ACTIVE') {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        border: Border.all(color: kSmoke, width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const ProfilePic(),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Hoang Minh Thang Hoang Minh Thang Hoang Minh Thang',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'noone@gmail.com',
                      style: TextStyle(color: kSmoke),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset(
                'assets/icons/arrow_forward_right_icon.svg',
                color: kSecondaryColor,
                width: 18,
              ),
            ],
          ),
          // Size
          // ProfileConfirm(active: true),
        ],
      ),
    );
  }
}
