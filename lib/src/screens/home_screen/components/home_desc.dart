import 'package:easy_clip_2_gif/src/widgets/shared/page_description.dart';
import 'package:flutter/material.dart';

class HomeDesc extends StatelessWidget {
  const HomeDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageDescription(
      title: "EasyClip2Gif Converter",
      subtitle: "Easy convert your videos/clips to GIF images.",
    );
  }
}
