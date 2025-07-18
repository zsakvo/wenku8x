import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/app/utils/flash.dart';

class PreferenceDropDownTile extends StatefulHookConsumerWidget {
  const PreferenceDropDownTile({
    super.key,
    required this.title,
    required this.values,
    this.onSelected,
    required this.value,
  });
  final String title;
  final List<Map<String, dynamic>> values;
  final Function(dynamic value)? onSelected;
  final dynamic value;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PreferenceDropDownTileState();
}

class _PreferenceDropDownTileState
    extends ConsumerState<PreferenceDropDownTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      onTap: () {
        showSelectionDialog(
          title: widget.title,
          values: widget.values,
          value: widget.value,
          onSelected: (widget.onSelected ?? (value) {}),
        );
      },
      subtitle: Padding(
        padding: EdgeInsets.only(top: 0),
        child: Text(
          widget.values.firstWhere(
            (element) => element['value'] == widget.value,
          )['title'],
          style: TextStyle(
            fontSize: 13,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(140),
          ),
        ),
      ),
      trailing: Padding(
        padding: EdgeInsets.only(right: 4),
        child: SvgPicture.asset(
          "assets/svg/ic_arrowtriangle_down.svg",
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onSurface.withAlpha(140),
            BlendMode.srcIn,
          ),
          width: 10,
        ),
      ),
    );
  }
}
