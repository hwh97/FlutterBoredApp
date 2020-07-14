import 'package:bored/consts/config_constants.dart';
import 'package:bored/models/bored_entity.dart';
import 'package:bored/routers/home_router.dart';
import 'package:bored/service_locator.dart';
import 'package:bored/services/bored/bored_api.dart';
import 'package:bored/utils/router_util.dart';
import 'package:bored/utils/sp_util.dart';
import 'package:bored/view_models/app_view_model.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPageViewModel extends ChangeNotifier {
  final BoredApi _boredApi = serviceLocator<BoredApi>();
  final RouterUtil _routers = serviceLocator.get<RouterUtil>();

  void prepareData(BuildContext context) async {
    BoredEntity _boredEntity;
    try {
      _boredEntity = await _boredApi.getRandomBored(timeOutMills: 1500);
    } catch (e) {
      debugPrint("splash page err: ${e.toString()}");
    } finally {
      _routers.navigateTo(
        HomeRouter.home,
        params: {"data": _boredEntity?.toJson()},
        replace: true,
        transition: TransitionType.fadeIn,
      );
    }
  }

  // load from share preference
  Future initApp(BuildContext context) async {
    int darkMode = serviceLocator.get<SpUtil>().getInt(ConfigConstants.darkModeKey);
    if (darkMode != null) {
      Provider.of<AppViewModel>(context, listen: false).initDarkMode(AppThemeModel.values[darkMode]);
    }

    String languageCode = serviceLocator.get<SpUtil>().getString(ConfigConstants.languageKey);
    if (languageCode != null && languageCode.isNotEmpty) {
      Provider.of<AppViewModel>(context, listen: false).setLocale(
        locale: Locale(languageCode),
        isFollowSystem: false,
      );
    } else {
      Provider.of<AppViewModel>(context, listen: false).setLocale(
        locale: await Devicelocale.currentAsLocale,
        isFollowSystem: true,
      );
    }
  }
}