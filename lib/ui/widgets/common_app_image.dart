import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

/// Common app image which handles network, assets and local file paths
class CommonAppImage extends StatelessWidget {
  final String imagePath;
  final double radius;
  final double height;
  final double width;
  final BoxFit fit;

  const CommonAppImage({
    Key? key,
    required this.imagePath,
    required this.height,
    required this.width,
    this.radius = 0,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
      child: imagePath.startsWith('http')
          ? imagePath.endsWith('svg')
              ? SvgPicture.network(
                  imagePath,
                  height: height,
                  width: width,
                  fit: fit,
                )
              : Image.network(
                  imagePath,
                  height: height,
                  width: width,
                  fit: fit,
                )
          : imagePath.contains('assets')
              ? imagePath.endsWith('svg')
                  ? SvgPicture.asset(
                      imagePath,
                      height: height,
                      width: width,
                      fit: fit,
                    )
                  : Image.asset(
                      imagePath,
                      height: height,
                      width: width,
                      fit: fit,
                    )
              : imagePath.endsWith('svg')
                  ? SvgPicture.file(
                      File(imagePath),
                      height: height,
                      width: width,
                      fit: fit,
                    )
                  : Image.file(
                      File(imagePath),
                      height: height,
                      width: width,
                      fit: fit,
                    ),
    );
  }
}
