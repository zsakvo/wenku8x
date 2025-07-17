import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PreferenceDropDownTile extends StatefulHookConsumerWidget {
  const PreferenceDropDownTile({super.key, required this.title});
  final String title;

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
      subtitle: Padding(
        padding: EdgeInsets.only(top: 0),
        child: Text(
          "跟随系统",
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
