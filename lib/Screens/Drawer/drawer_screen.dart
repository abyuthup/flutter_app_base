import 'package:flutter/material.dart';
import 'package:flutter_baseapp/Helpers/config.dart';
import 'package:flutter_baseapp/Screens/Home/home_screen.dart';
import 'package:flutter_baseapp/Screens/Settings/settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  static const int HomePageIndex = 0, SettingsPageIndex = 2;
  late int selectedDrawerItem;

  @override
  void initState() {
    super.initState();
    selectedDrawerItem = HomePageIndex;
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("Aby Uthup"),
              accountEmail: const Text("***@gmail.com"),
              decoration: BoxDecoration(
                color: currentTheme.currentColor(),
              ),
              currentAccountPicture: const CircleAvatar(
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.home),
              subtitle: Text(''),
              leading: const Icon(
                Icons.home,
                size: 24.0,
              ),
              onTap: () {
                setState(() {
                  selectedDrawerItem = HomePageIndex;
                });
                Navigator.pop(context);
                // Navigator.pop(context);
                // Navigator.pushNamed(context, '/setting');
                // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.settings),
              subtitle: Text(''),
              leading: const Icon(
                Icons.settings,
                size: 24.0,
              ),
              onTap: () {
                setState(() {
                  selectedDrawerItem = SettingsPageIndex;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: returnPage(),
    );
  }

  Widget returnPage() {
    Widget page;
    switch (selectedDrawerItem) {
      case HomePageIndex:
        page = const HomePage();
        break;
      case SettingsPageIndex:
        page = const SettingPage();
        break;
      default:
        page = const HomePage();
    }
    return page;
  }
}
