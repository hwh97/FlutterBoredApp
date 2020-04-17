import 'package:bored/business_logic/models/bored_entity.dart';
import 'package:bored/business_logic/utils/date_util.dart';
import 'package:bored/business_logic/view_models/bored_page_view_model.dart';
import 'package:bored/business_logic/view_models/app_view_model.dart';
import 'package:bored/consts/asset_constants.dart';
import 'package:bored/service_locator.dart';
import 'package:bored/ui/widget/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class BoredPage extends StatefulWidget {
  BoredPage({Key key, this.title, this.boredEntity}) : super(key: key);

  final String title;
  final BoredEntity boredEntity;

  @override
  _BoredPageState createState() => _BoredPageState();
}

class _BoredPageState extends State<BoredPage>
    with TickerProviderStateMixin {
  final BoredPageViewModel _viewModel =
      serviceLocator.get<BoredPageViewModel>();
  AnimationController _refreshAnimationCtl;
  CurvedAnimation _curve;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Provider.of<AppViewModel>(context).isDark(context)
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 16.w,
            left: 10.w,
            right: 10.w,
          ),
          shrinkWrap: false,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            _titleBar,
            SizedBox(
              height: 20.w,
            ),
            _activityHeader,
            _activityArea,
            SizedBox(
              height: 20.w,
            ),
            _todoListHeader,
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _refreshAnimationCtl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _curve = CurvedAnimation(parent: _refreshAnimationCtl, curve: Curves.ease);
    widget.boredEntity == null
        ? _viewModel.loadData(_refreshAnimationCtl)
        : _viewModel.init(widget.boredEntity);
  }

  @override
  void dispose() {
    _refreshAnimationCtl?.dispose();
    super.dispose();
  }

  Widget get _titleBar => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 28.sp,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8.w,
              ),
              Text(
                DateUtil.formatDate(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 36.w,
            height: 36.w,
            child: Provider.of<AppViewModel>(context, listen: false)
                    .isDark(context)
                ? FloatingActionButton(
                    heroTag: "night-tag",
                    onPressed: () =>
                        Provider.of<AppViewModel>(context, listen: false)
                            .setDarkModel(ThemeModel.Light),
                    tooltip: "Day mode",
                    child: SvgPicture.asset(
                      AssetConstants.daySvg,
                      color: Color(0x98FFFFFF),
                      width: 22.w,
                      height: 22.w,
                    ),
                  )
                : FloatingActionButton(
                    heroTag: "day-tag",
                    onPressed: () =>
                        Provider.of<AppViewModel>(context, listen: false)
                            .setDarkModel(ThemeModel.Dark),
                    tooltip: 'Night mode',
                    child: SvgPicture.asset(
                      AssetConstants.nightSvg,
                      color: Colors.white,
                      width: 22.w,
                      height: 22.w,
                    ),
                  ),
          ),
        ],
      );

  Widget get _activityHeader => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Activity",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20.w),
            child: SizedBox(
              width: 40.w,
              height: 40.w,
              child: RotationTransition(
                turns: _curve,
                child: Icon(
                  Icons.refresh,
                  size: 26.w,
                  color: Color(0xFFA0AFC6),
                ),
              ),
            ),
            onTap: () => _viewModel.loadData(_refreshAnimationCtl),
          ),
        ],
      );

  Widget get _activityArea => ChangeNotifierProvider.value(
        value: _viewModel,
        child: Consumer<BoredPageViewModel>(
          builder: (ctx, model, child) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 10.w,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        blurRadius: 10.0, // soften the shadow
                        spreadRadius: 0.0, //extend the s
                      ),
                    ],
                  ),
                  child: ClipRect(
                    child: Banner(
                      message: model.boredEntity?.type ?? "",
                      location: BannerLocation.bottomEnd,
                      color: Theme.of(context).primaryColor,
                      child: Container(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.symmetric(
                          vertical: 10.w,
                          horizontal: 6.w,
                        ),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            AnimatedSize(
                              duration: Duration(milliseconds: 80),
                              curve: Curves.linear,
                              vsync: this,
                              child: SizedBox(
                                width: double.maxFinite,
                                child: Text(
                                  model.boredEntity?.activity ?? "Loading",
                                  style: TextStyle(
                                    color:
                                    Provider.of<AppViewModel>(context).isDark(context)
                                        ? Colors.white
                                        : Theme.of(context).primaryColor,
                                    height: 1.2.w,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                descTextWidget("accessibility:"),
                                SizedBox(
                                  width: 10.w,
                                ),
                                ProgressBar(
                                  size: Size(200.w, 6.w),
                                  borderRadius: BorderRadius.circular(6.w),
                                  value: model.boredEntity?.accessibility != null &&
                                          model.boredEntity.accessibility.isNotEmpty
                                      ? double.parse(model.boredEntity?.accessibility)
                                      : 0.0,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                descTextWidget("price:"),
                                SizedBox(
                                  width: 10.w,
                                ),
                                ProgressBar(
                                  size: Size(200.w, 6.w),
                                  borderRadius: BorderRadius.circular(6.w),
                                  value: model.boredEntity?.price != null &&
                                      model.boredEntity.price.isNotEmpty
                                      ? double.parse(model.boredEntity?.price)
                                      : 0.0,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.w,
                            ),
                            SizedBox(
                              height: 20.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  descTextWidget("participants:"),
                                  Expanded(
                                    child: ListView(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      children: List.generate(
                                        model.boredEntity?.participants ?? 0,
                                        (index) {
                                          return Padding(
                                            padding: index == 0
                                                ? EdgeInsets.zero
                                                : EdgeInsets.only(left: 6.w),
                                            child: Icon(
                                              Icons.mood,
                                              size: 16,
                                              color: Theme.of(context).hintColor,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );

  Widget descTextWidget(String text) {
    return SizedBox(
      width: 70.w,
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).hintColor,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget get _todoListHeader => Text(
        "TODO List",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w800,
        ),
      );
}
