import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:your_tours_mobile/apis/booking_apis.dart';
import 'package:your_tours_mobile/components/loading_overlay.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/controllers/view_comment_controller.dart';
import 'package:your_tours_mobile/models/requests/create_comment_request.dart';
import 'package:your_tours_mobile/size_config.dart';

class BookingEvaluateScreen extends StatefulWidget {
  final String bookingId;
  final HandleViewCommentController handleViewCommentController;

  const BookingEvaluateScreen(
      {Key? key,
      required this.bookingId,
      required this.handleViewCommentController})
      : super(key: key);

  @override
  State<BookingEvaluateScreen> createState() => _BookingEvaluateScreenState();
}

class _BookingEvaluateScreenState extends State<BookingEvaluateScreen> {
  late double rating = 0;
  late String comment = '';

  Future<void> callApiEvaluate() async {
    try {
      if (rating == 0) {
        throw const FormatException("Bạn chưa chọn xếp hạng");
      }

      await LoadingOverlay.of(context).during(
          future: createCommentApi(CreateCommentRequest(
              bookId: widget.bookingId, rates: rating, comment: comment)));

      widget.handleViewCommentController.setView(rating, comment);

      if (!mounted) {
        return;
      }

      AnimatedSnackBar.material(
        "Gửi đánh giá thành công",
        type: AnimatedSnackBarType.success,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      ).show(context);

      Navigator.pop(context);
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
              const Expanded(
                child: Text(
                  'Evaluate',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(color: Colors.white, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 1,
                      )
                    ],
                  ),
                  child: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SmoothStarRating(
            allowHalfRating: true,
            onRatingChanged: (v) {
              rating = v;
              setState(() {});
            },
            starCount: 5,
            rating: rating,
            size: 50.0,
            color: kPrimaryColor,
            borderColor: kPrimaryColor,
            spacing: 0.0),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: const Border(
                  top: BorderSide(width: 1.0, color: kBody),
                  bottom: BorderSide(width: 1.0, color: kBody),
                  left: BorderSide(width: 1.0, color: kBody),
                  right: BorderSide(width: 1.0, color: kBody),
                ),
              ),
              child: TextField(
                onChanged: (value) {
                  comment = value;
                },
                maxLines: 5,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenWidth(12)),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "Write your comment here ...",
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(kPrimaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
                callApiEvaluate();
              },
              child: const Text('Gửi đánh giá',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
