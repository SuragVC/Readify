import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';

class BookContainer extends StatelessWidget {
  const BookContainer({
    Key? key,
    required this.title,
    this.imageUrl,
    required this.containerHeight,
    required this.containerWidth,
  }) : super(key: key);

  final String title;
  final String? imageUrl;
  final double containerHeight;
  final double containerWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: imageUrl != null
                ? ProgressiveImage(
                    placeholder: NetworkImage(imageUrl!),
                    thumbnail: NetworkImage(imageUrl!),
                    image: NetworkImage(imageUrl!),
                    width: containerWidth,
                    height: containerHeight - 20,
                  )
                : Image.asset(
                    "assets/images/no_image_available.jpg",
                    width: containerWidth,
                    height: containerHeight - 20,
                  ),
          ),
          SizedBox(
            width: containerWidth,
            height: 20,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
