import 'package:bored/consts/asset_constants.dart';
import 'package:bored/routers/Routers.dart';
import 'package:bored/routers/home_router.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'bored_page.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: FlareActor(
        AssetConstants.splashFlr,
        alignment: Alignment.center,
        fit: BoxFit.fill,
        animation: "Preview2",
        snapToEnd: true,
        sizeFromArtboard: true,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500)).then((_) {
      Routers.navigateTo(
        context,
        HomeRouter.home,
        params: {"title": "无聊消灭器"},
        replace: true,
        transition: TransitionType.fadeIn,
      );
    });
  }
}
