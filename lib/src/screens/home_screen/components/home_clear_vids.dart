import 'package:easy_clip_2_gif/src/constants/text_styles.dart';
import 'package:easy_clip_2_gif/src/controllers/video_panel_controller.dart';
import 'package:easy_clip_2_gif/src/utils/show_confirm_dialog.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/row_separated.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeClearVids extends StatefulWidget {
  const HomeClearVids({super.key});

  @override
  State<HomeClearVids> createState() => _HomeClearVidsState();
}

class _HomeClearVidsState extends State<HomeClearVids> {
  late final _videoPanelController = context.read<VideoPanelController>();
  bool get _isGridEmpty => _videoPanelController.videos.isEmpty;
  Color get _textColor => Theme.of(context).textTheme.bodyMedium!.color!;
  late bool _isGridEmptyState;

  void _clearVids() => showConfirmDialog(
        context,
        title: "Remove videos",
        description:
            "Are you sure that you want to remove all the videos from the grid selection?",
        onTap: (bool isOk) {
          if (isOk) {
            _videoPanelController.clearVids();
          }

          context.pop();
        },
      );

  void _updateGridState() {
    if (mounted && _isGridEmptyState != _isGridEmpty) {
      setState(() {
        _isGridEmptyState = _isGridEmpty;
      });
    }
  }

  @override
  void initState() {
    _isGridEmptyState = _isGridEmpty;
    _videoPanelController.addListener(_updateGridState);
    super.initState();
  }

  @override
  void dispose() {
    _videoPanelController.removeListener(_updateGridState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (!_isGridEmpty) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _clearVids,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  child: RowSeparated(
                    spacing: 8,
                    children: [
                      Icon(
                        Icons.close,
                        size: TextStyles.regular.fontSize!,
                        color: _textColor.withOpacity(0.7),
                      ),
                      Text(
                        "Clear videos",
                        style: TextStyles.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: _textColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
