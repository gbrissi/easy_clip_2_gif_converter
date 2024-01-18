import 'package:easy_clip_2_gif/src/controllers/video_panel_controller.dart';
import 'package:easy_clip_2_gif/src/screens/home_screen/components/home_add_vid.dart';
import 'package:easy_clip_2_gif/src/screens/home_screen/components/home_grid_mode.dart';
import 'package:easy_clip_2_gif/src/widgets/player/providers/layout_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/shared/row_separated.dart';
import 'components/home_clear_vids.dart';
import 'components/home_desc.dart';
import 'components/home_vid_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VideoPanelController(),
        ),
        ChangeNotifierProvider(
          create: (_) => LayoutController(),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // spacing: 12,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              bottom: 12,
            ),
            child: HomeDesc(),
          ),
          const HomeGridMode(),
          const Flexible(
            child: HomeVidGrid(),
          ),
          RowSeparated(
            spacing: 4,
            children: const [
              HomeAddVid(),
              HomeClearVids(),
            ],
          )
        ],
      ),
    );
  }
}
