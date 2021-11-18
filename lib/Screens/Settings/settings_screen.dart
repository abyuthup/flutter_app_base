import 'package:flutter/material.dart';
import 'package:flutter_baseapp/CustomWidgets/gradient_containers.dart';
import 'package:flutter_baseapp/Helpers/common_keys.dart';
import 'package:flutter_baseapp/Helpers/config.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var pref = GetStorage();
  late String theme, themeColor;

  late int colorHue;

  // String theme =Hive.box('settings').get('theme', defaultValue: 'Default') as String;
  @override
  void initState() {
    super.initState();

    theme = (pref.read(key_theme) == null
        ? 'Default'
        : pref.read(key_theme) as String);
    themeColor = (pref.read(key_themeColor) == null)
        ? 'Teal'
        : pref.read(key_themeColor) as String;

    colorHue = (pref.read(key_colorHue) == null)
        ? 400
        : pref.read(key_colorHue) as int;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BoxSwitchTile(
          Pref: pref,
          title: Text(AppLocalizations.of(context)!.darkMode),
          keyName: key_darkMode,
          Value: currentTheme.currentTheme() == ThemeMode.dark,
          onChanged: (bool val, GetStorage pref) {
            pref.write(key_useSystemTheme, false.toString());
            currentTheme.switchTheme(
              isDark: val,
              useSystemTheme: false,
            );
            switchToCustomTheme();
            setState(() {});
          },
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context)!.accent,
          ),
          subtitle: Text(AppLocalizations.of(context)!.themeColor),
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
                final List<String> colors = [
                  'Purple',
                  'Deep Purple',
                  'Indigo',
                  'Blue',
                  'Light Blue',
                  'Cyan',
                  'Teal',
                  'Green',
                  'Light Green',
                  'Lime',
                  'Yellow',
                  'Amber',
                  'Orange',
                  'Deep Orange',
                  'Red',
                  'Pink',
                ];
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
                    itemCount: colors.length,
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
                                  themeColor = colors[index];
                                  colorHue = hue;
                                  currentTheme.switchColor(
                                    colors[index],
                                    colorHue,
                                  );
                                  setState(
                                    () {},
                                  );
                                  switchToCustomTheme();
                                  Navigator.pop(context);
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
                                      colors[index],
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
                                  child: (themeColor == colors[index] &&
                                          colorHue == hue)
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

  void switchToCustomTheme() {
    const custom = 'Custom';
    if (theme != custom) {
      currentTheme.setInitialTheme(custom);
      setState(
        () {
          theme = custom;
        },
      );
    }
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

/*    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: (BuildContext context, Box box, Widget? widget) {
        return SwitchListTile(
          activeColor: Theme.of(context).colorScheme.secondary,
          title: title,
          subtitle: subtitle,
          isThreeLine: isThreeLine ?? false,
          dense: true,
          value: box.get(keyName, defaultValue: defaultValue) as bool? ??
              defaultValue,
          onChanged: (val) {
            box.put(keyName, val);
            onChanged?.call(val, box);
          },
        );
      },
    );*/
  }
}
