import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_tours_mobile/apis/comment_apis.dart';
import 'package:your_tours_mobile/components/loading_api_widget.dart';
import 'package:your_tours_mobile/components/shimmer_loading.dart';
import 'package:your_tours_mobile/constants.dart';
import 'package:your_tours_mobile/models/responses/comment_response.dart';
import 'package:your_tours_mobile/size_config.dart';

class CommentSection extends StatefulWidget {
  final String homeId;

  const CommentSection({Key? key, required this.homeId}) : super(key: key);

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  Future<GetPageCommentResponse?> _fetchDataPageCommentApi() async {
    try {
      return await getPageCommentApi(widget.homeId);
    } on FormatException catch (error) {
      AnimatedSnackBar.material(
        error.message,
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
      ).show(context);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return LoadApiWidget<GetPageCommentResponse?>(
        autoRefresh: true,
        successBuilder: (context, response) {
          return successWidget(context, response!);
        },
        loadingBuilder: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: List.generate(
                3,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ShimmerLoading(
                        width: SizeConfig.screenWidth,
                        height: 60,
                        boxShape: BoxShape.rectangle,
                      ),
                    )),
          ),
        ),
        fetchDataFunction: _fetchDataPageCommentApi());
  }

  Widget successWidget(BuildContext context, GetPageCommentResponse response) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: response.data.content.length,
      itemBuilder: (context, index) {
        return CommentCard(
          commentInfo: response.data.content[index],
        );
      },
    );
  }
}

class CommentCard extends StatelessWidget {
  final CommentInfo commentInfo;

  const CommentCard({Key? key, required this.commentInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(18.0)),
              child: Image.network(
                commentInfo.avatar != null
                    ? commentInfo.avatar!
                    : "https://static.vecteezy.com/system/resources/thumbnails/002/002/403/small/man-with-beard-avatar-character-isolated-icon-free-vector.jpg",
                fit: BoxFit.cover,
                height: 50,
                width: 50,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      commentInfo.fullName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/Star Icon.svg',
                          width: 14,
                          height: 14,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          commentInfo.rates.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  commentInfo.comment,
                  style: const TextStyle(color: kSmoke),
                )
              ],
            )),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ],
    );
  }
}
