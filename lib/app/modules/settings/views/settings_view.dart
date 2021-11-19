import 'package:flutter/material.dart';
import 'package:flutter_baseapp/Utils/common_keys.dart';
import 'package:flutter_baseapp/Utils/themes.dart';
import 'package:flutter_baseapp/app/modules/settings/controllers/settings_controller.dart';
import 'package:flutter_baseapp/app/widgets/gradient_container.dart';
import 'package:flutter_baseapp/generated/l10n.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingsView> {
  SettingsController controller = Get.put(SettingsController());


  // String theme =Hive.box('settings').get('theme', defaultValue: 'Default') as String;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BoxSwitchTile(
          Pref: controller.pref,
          title: Text(S.of(context).darkMode),
          keyName: key_darkMode,
          Value: currentTheme.currentTheme() == ThemeMode.dark,
          onChanged: (bool val, GetStorage pref) {
            pref.write(key_useSystemTheme, false.toString());
            currentTheme.switchTheme(
              isDark: val,
              useSystemTheme: false,
            );
            controller.switchToCustomTheme();
            setState(() {});
          },
        ),
        ListTile(
          title: Text(
            S.of(context).accent,
          ),
          subtitle: Text(S.of(context).themeColor),
          trailing: Padding(
            padding: const EdgeInsets.all(
              10.0,
            ),
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  100.0,
                ),
                color: Theme.of(context).colorScheme.secondary,
                boxShadow: (currentTheme.currentTheme() == ThemeMode.dark)
                    ? null
                    : [
                  BoxShadow(
                    color: Colors.grey[400]!,
                    blurRadius: 5.0,
                    offset: const Offset(
                      0.0,
                      3.0,
                    ),
                  )
                ],
              ),
            ),
          ),
          onTap: () {
            showModalBottomSheet(
              isDismissible: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return BottomGradientContainer(
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      0,
                      10,
                      0,
                      10,
                    ),
                    itemCount: controller.colors.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 15.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int hue in [100, 200, 400, 700])
                              GestureDetector(
                                onTap: () {
                                  controller.themeColor = controller.colors[index];
                                  controller.colorHue = hue;
                                  currentTheme.switchColor(
                                    controller.colors[index],
                                    controller.colorHue,
                                  );
                                  setState(
                                        () {},
                                  );
                                  controller.switchToCustomTheme();
                                  Get.back();
                                },
                                child: Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.125,
                                  height:
                                  MediaQuery.of(context).size.width * 0.125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      100.0,
                                    ),
                                    color: MyTheme().getColor(
                                      controller.colors[index],
                                      hue,
                                    ),
                                    boxShadow: (currentTheme.currentTheme() ==
                                        ThemeMode.dark)
                                        ? null
                                        : [
                                      BoxShadow(
                                        color: Colors.grey[400]!,
                                        blurRadius: 5.0,
                                        offset: const Offset(
                                          0.0,
                                          3.0,
                                        ),
                                      )
                                    ],
                                  ),
                                  child: (controller.themeColor == controller.colors[index] &&
                                      controller.colorHue == hue)
                                      ? const Icon(
                                    Icons.done_rounded,
                                  )
                                      : const SizedBox(),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
          dense: true,
        ),
      ],
    );
  }


}

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
      activeColor: Theme.of(context).colorScheme.secondary,
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