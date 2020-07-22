import 'package:bored/generated/l10n.dart';
import 'package:bored/service_locator.dart';
import 'package:bored/utils/dialog_util.dart';
import 'package:bored/view_models/app_view_model.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class SettingPageViewModel extends ChangeNotifier {
  String version = "";
  List<SettingItemModel> items;
  final DialogUtil _dialogUtil = serviceLocator.get<DialogUtil>();

  void loadVersionInfo(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = S.of(context).versionDesc(packageInfo.version);
    notifyListeners();
  }

  void loadItems(BuildContext context) {
    // dark mode subtitle
    String darkModeSubTitle =
        Provider.of<AppViewModel>(context, listen: false).themeModel ==
                AppThemeModel.System
            ? S.of(context).auto
            : Provider.of<AppViewModel>(context, listen: false).themeModel ==
                    AppThemeModel.Light
                ? S.of(context).normalModeOption
                : S.of(context).darkModeOption;
    // language subtitle
    String languageSubTitle =
        Provider.of<AppViewModel>(context, listen: false).appLanguage ==
                AppLanguage.System
            ? S.of(context).auto
            : Provider.of<AppViewModel>(context, listen: false).appLanguage ==
                    AppLanguage.Chinese
                ? S.of(context).simplifiedZh
                : S.of(context).english;

    items = [
      SettingItemModel(
        title: S.of(context).darkMode,
        subTitle: darkModeSubTitle,
        onTap: () => onShowDarkModeDialog(context),
      ),
      SettingItemModel(
        title: S.of(context).language,
        subTitle: languageSubTitle,
        onTap: () => onShowLanguageDialog(context),
      ),
    ];
    notifyListeners();
  }

  void onShowDarkModeDialog(BuildContext context) {
    void onSelectDarkMode(int index) async {
      Provider.of<AppViewModel>(context, listen: false).setDarkMode(AppThemeModel.values[index]);
    }

    _dialogUtil.showSimpleDialog(
      title: S.of(context).darkModeDialogTitle,
      options: [
        S.of(context).auto,
        S.of(context).normalModeOption,
        S.of(context).darkModeDialogTitle
      ],
      initialIndex:
          Provider.of<AppViewModel>(context, listen: false).themeModel ==
                  AppThemeModel.System
              ? 0
              : Provider.of<AppViewModel>(context, listen: false).themeModel ==
                      AppThemeModel.Light
                  ? 1
                  : 2,
      onSelectSimpleDialog: onSelectDarkMode,
    );
  }

  void onShowLanguageDialog(BuildContext context) {
    void onSelectLanguage(int index) async {
      if (index == 0) {
        await Provider.of<AppViewModel>(context, listen: false).setLocale(
          locale: await Devicelocale.currentAsLocale,
          isFollowSystem: true,
        );
      } else {
        await Provider.of<AppViewModel>(context, listen: false).setLocale(
          locale: Locale(index == 1 ? "zh" : "en"),
          isFollowSystem: false,
        );
      }
    }

    _dialogUtil.showSimpleDialog(
      title: S.of(context).languageDialogTitle,
      options: [
        S.of(context).auto,
        S.of(context).simplifiedZh,
        S.of(context).english
      ],
      initialIndex:
          Provider.of<AppViewModel>(context, listen: false).appLanguage ==
                  AppLanguage.System
              ? 0
              : Provider.of<AppViewModel>(context, listen: false).appLanguage ==
                      AppLanguage.Chinese
                  ? 1
                  : 2,
      onSelectSimpleDialog: onSelectLanguage,
    );
  }
}

class SettingItemModel {
  final VoidCallback onTap;
  final String title;
  final String subTitle;

  SettingItemModel({this.onTap, this.title, this.subTitle});
}
