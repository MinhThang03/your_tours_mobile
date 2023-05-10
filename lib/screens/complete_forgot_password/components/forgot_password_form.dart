import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:your_tours_mobile/apis/forgot_password_api.dart';
import 'package:your_tours_mobile/components/custom_surfix_icon.dart';
import 'package:your_tours_mobile/components/default_button.dart';
import 'package:your_tours_mobile/components/form_error.dart';
import 'package:your_tours_mobile/components/loading_overlay.dart';
import 'package:your_tours_mobile/models/requests/forgot_password_request.dart';
import 'package:your_tours_mobile/screens/sign_in/sign_in_screen.dart';

import '../../../size_config.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  TextEditingController otpController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    confirmPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? _otp;
  String? _confirmPassword;
  String? _newPassword;

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
      ResetPasswordRequest request = ResetPasswordRequest(
          otp: otpController.text,
          newPassword: newPasswordController.text,
          confirmPassword: confirmPasswordController.text);

      await LoadingOverlay.of(context)
          .during(future: resetPasswordApi(request));

      if (!mounted) return;

      AnimatedSnackBar.material(
        "Cập nhật mật khẩu thành công",
        type: AnimatedSnackBarType.success,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      ).show(context);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
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
          SizedBox(height: getProportionateScreenHeight(30)),
          buildOtpFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildNewPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConfirmPasswordFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Đổi mật khẩu",
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

  TextFormField buildOtpFormField() {
    return TextFormField(
      controller: otpController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => _otp = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Nhập mã otp");
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Nhập mã otp");
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Otp",
        hintText: "Nhập mã otp",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/otp_icon.svg"),
      ),
    );
  }

  TextFormField buildNewPasswordFormField() {
    return TextFormField(
      controller: newPasswordController,
      onSaved: (newValue) => _newPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Nhập mật khẩu mới");
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Nhập mật khẩu mới");
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Mật khẩu mới",
        hintText: "Nhập mật khẩu mới",
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/new_password_icon.svg"),
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      controller: confirmPasswordController,
      onSaved: (newValue) => _confirmPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Nhập xác nhận mật khẩu mới");
        }

        if (value == newPasswordController.text) {
          removeError(error: "Xác nhận mật khẩu không khớp");
        }

        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Nhập xác nhận mật khẩu mới");
          return "";
        }

        if (value != newPasswordController.text) {
          addError(error: "Xác nhận mật khẩu không khớp");
          return "";
        }

        return null;
      },
      decoration: const InputDecoration(
        labelText: "Xác nhận mật khẩu",
        hintText: "Nhập lại mật khẩu mới",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/new_password_icon.svg"),
      ),
    );
  }
}
