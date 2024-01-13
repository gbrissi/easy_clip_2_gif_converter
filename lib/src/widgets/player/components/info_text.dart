import 'package:easy_clip_2_gif/src/constants/text_styles.dart';
import 'package:easy_clip_2_gif/src/widgets/player/components/info_label.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/row_separated.dart';
import 'package:flutter/material.dart';

import 'info_text_button.dart';

class InfoText extends StatefulWidget {
  const InfoText({
    super.key,
    required this.label,
    required this.text,
    this.edit = false,
  });
  final String label;
  final String text;
  final bool edit;

  @override
  State<InfoText> createState() => _InfoTextState();
}

class _InfoTextState extends State<InfoText> {
  final ValueNotifier<bool> _isEditEnabled = ValueNotifier(false);
  String? _initialEditValue;
  final SizedBox _emptyBox = const SizedBox.shrink();
  final FocusNode _focusNode = FocusNode();
  late final TextEditingController _controller = TextEditingController(
    text: widget.text,
  );

  @override
  void didUpdateWidget(oldWidget) {
    if (oldWidget.text != widget.text) {
      _controller.text = widget.text;
    }

    super.didUpdateWidget(oldWidget);
  }

  Color get hintColor =>
      Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.6);

  void _enableEdit() {
    _focusNode.requestFocus();
    setState(() {
      _initialEditValue = _controller.text;
      _isEditEnabled.value = true;
    });
  }

  void _confirmEdit() {
    setState(() {
      _isEditEnabled.value = false;
    });
  }

  void _cancelEdit() {
    _controller.text = _initialEditValue!;
    setState(() {
      _isEditEnabled.value = false;
    });
  }

  Widget get _editIcon => !_isEditEnabled.value && widget.edit
      ? InfoTextButton(
          onTap: _enableEdit,
          icon: Icons.edit,
          color: Colors.orange,
        )
      : _emptyBox;

  Widget get _confirmIcon => _isEditEnabled.value
      ? InfoTextButton(
          onTap: _confirmEdit,
          icon: Icons.done,
          color: Colors.green,
        )
      : _emptyBox;

  Widget get _cancelIcon => _isEditEnabled.value
      ? InfoTextButton(
          onTap: _cancelEdit,
          icon: Icons.close,
          color: Colors.red,
        )
      : _emptyBox;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: InfoLabel(
            label: widget.label,
          ),
        ),
        Flexible(
          child: IntrinsicWidth(
            child: TextField(
              focusNode: _focusNode,
              readOnly: !_isEditEnabled.value,
              maxLines: 1,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: _controller.text.isEmpty
                    ? "This field mustn't be empty"
                    : "",
                hintStyle: TextStyles.small.copyWith(
                  color: hintColor,
                ),
                contentPadding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              controller: _controller,
              style: TextStyles.small.copyWith(
                color: Theme.of(context).textTheme.bodyMedium!.color!,
              ),
            ),
          ),
        ),
        RowSeparated(
          spacing: 4,
          children: [
            _editIcon,
            _cancelIcon,
            _confirmIcon,
          ].where((e) => e != _emptyBox).toList(),
        ),
      ],
    );
  }
}

// return Text.rich(
//   TextSpan(
//     children: [
//       TextSpan(
//         text: "${widget.label}: ",
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       WidgetSpan(
//         child: TextField(
//           controller: _controller,
//         ),
//       )
//     ],
//   ),
//   style: TextStyles.small,
// );