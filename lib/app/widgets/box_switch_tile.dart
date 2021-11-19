import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class BoxSwitchTile extends StatelessWidget {
  const BoxSwitchTile({
    Key? key,
    required this.Pref,
    required this.title,
    this.subtitle,
    required this.keyName,
    required this.Value,
    this.isThreeLine,
    this.onChanged,
  }) : super(key: key);

  final Text title;
  final Text? subtitle;
  final String keyName;
  final bool Value;
  final GetStorage Pref;
  final bool? isThreeLine;
  final Function(bool, GetStorage box)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      activeColor: Theme
          .of(context)
          .colorScheme
          .secondary,
      title: title,
      subtitle: subtitle,
      isThreeLine: isThreeLine ?? false,
      dense: true,
      value: Value,
      onChanged: (val) {
        Pref.write(keyName, val);
        onChanged?.call(val, Pref);
      },
    );
  }
}