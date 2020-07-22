import 'package:bored/view_models/splash_page_view_model.dart';
import 'package:bored/consts/asset_constants.dart';
import 'package:bored/service_locator.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  final SplashPageViewModel _splashPageViewModel = serviceLocator.get<SplashPageViewModel>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 375, height: 667, allowFontScaling: false);
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: FlareActor(
        AssetConstants.splashFlr,
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "Preview2",
        snapToEnd: true,
        sizeFromArtboard: true,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() async {
    // load language
    await _splashPageViewModel.initApp(context);
    // prepare data and go to main page
    _splashPageViewModel.prepareData(context);
  }
}
