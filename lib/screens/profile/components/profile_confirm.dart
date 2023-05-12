import 'package:flutter/material.dart';

class ProfileConfirm extends StatefulWidget {
  final bool active;

  const ProfileConfirm({Key? key, required this.active}) : super(key: key);

  @override
  State<ProfileConfirm> createState() => _ProfileConfirmState();
}

class _ProfileConfirmState extends State<ProfileConfirm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1,
            color: widget.active ? Colors.blue : Colors.red,
          )),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.active ? Icons.check_circle_outline : Icons.cancel_outlined,
            size: 18,
            color: widget.active ? Colors.blue : Colors.red,
          ),
          const SizedBox(
            width: 6,
          ),
          Center(
            child: Text(
              widget.active ? "Đã xác thực" : "Chưa xác thực",
              style: TextStyle(
                color: widget.active ? Colors.blue : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
