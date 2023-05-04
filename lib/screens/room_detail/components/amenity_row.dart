import 'package:flutter/material.dart';
import 'package:your_tours_mobile/models/responses/home_detail_response.dart';

class AmenityRow extends StatefulWidget {
  final AmenitiesView amenity;

  const AmenityRow({Key? key, required this.amenity}) : super(key: key);

  @override
  State<AmenityRow> createState() => _AmenityRowState();
}

class _AmenityRowState extends State<AmenityRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          widget.amenity.icon!,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(child: Text(widget.amenity.name,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            decoration: widget.amenity.isConfig == true ? TextDecoration.none : TextDecoration.lineThrough
          ),
        ))
      ],
    );
  }
}
