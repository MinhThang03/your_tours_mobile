import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_tours_mobile/apis/aws_apis.dart';
import 'package:your_tours_mobile/apis/user_api.dart';
import 'package:your_tours_mobile/components/custom_surfix_icon.dart';
import 'package:your_tours_mobile/components/default_button.dart';
import 'package:your_tours_mobile/components/form_error.dart';
import 'package:your_tours_mobile/components/loading_overlay.dart';
import 'package:your_tours_mobile/controllers/user_controller.dart';
import 'package:your_tours_mobile/models/responses/aws_response.dart';
import 'package:your_tours_mobile/models/responses/user_response.dart';
import 'package:your_tours_mobile/screens/complete_profile/components/profile_pic_selected.dart';

import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({super.key});

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  UserController userController = Get.find<UserController>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nameController.text = userController.userInfo.value.fullName ?? '';
    phoneController.text = userController.userInfo.value.phoneNumber ?? '';
    addressController.text = userController.userInfo.value.address ?? '';
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? name;
  String? phoneNumber;
  String? address;
  String? pathImage;

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  Future<void> _submit() async {
    try {
      String? avatar = userController.userInfo.value.avatar;

      if (pathImage != null && pathImage != '') {
        UpdateImageResponse responseImage = await LoadingOverlay.of(context)
            .during(future: uploadImageApi(pathImage!));
        avatar = responseImage.data.previewUrl;
        pathImage = null;
      }

      UserInfo currentUser = userController.userInfo.value;
      currentUser.avatar = avatar;
      currentUser.fullName =
          nameController.text.isEmpty ? null : nameController.text;
      currentUser.address =
          addressController.text.isEmpty ? null : addressController.text;
      currentUser.phoneNumber =
          phoneController.text.isEmpty ? null : phoneController.text;

      if (!mounted) return;

      await LoadingOverlay.of(context)
          .during(future: updateProfileApi(currentUser));

      userController.setUserInfo(currentUser);

      if (!mounted) return;

      AnimatedSnackBar.material(
        "Cập nhật thông tin thành công",
        type: AnimatedSnackBarType.success,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      ).show(context);
    } on FormatException catch (error) {
      AnimatedSnackBar.material(
        error.message,
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ProfilePicSelected(
            selectedImage: (value) {
              pathImage = value;
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Lưu",
            press: () {
              if (_formKey.currentState!.validate()) {
                _submit();
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: addressController,
      onSaved: (newValue) => address = newValue,
      decoration: const InputDecoration(
        labelText: "Địa chỉ",
        hintText: "Nhập địa chỉ của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Nhập số điện thoại");
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Nhập số điện thoại");
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Số điện thoại",
        hintText: "Nhập số điện thoại của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      controller: nameController,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Nhập họ và tên");
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Nhập họ và tên");
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Họ và tên",
        hintText: "Nhập tên của bạn",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
