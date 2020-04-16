import 'package:bored/business_logic/models/bored_entity.dart';
import 'package:bored/business_logic/utils/date_util.dart';
import 'package:bored/business_logic/view_models/bored_page_view_model.dart';
import 'package:bored/business_logic/view_models/app_view_model.dart';
import 'package:bored/consts/asset_constants.dart';
import 'package:bored/service_locator.dart';
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

class _BoredPageState extends State<BoredPage> {
  final BoredPageViewModel _viewModel =
      serviceLocator.get<BoredPageViewModel>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Provider.of<AppViewModel>(context).isDark(context)
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 6.w,
            left: 8.w,
            right: 8.w,
          ),
          shrinkWrap: false,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            _titleBar,
            SizedBox(
              height: 18.w,
            ),
            _activityHeader,
            _activityArea,
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _viewModel.loadData,
          tooltip: 'Refresh Activity',
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.boredEntity == null
        ? _viewModel.loadData()
        : _viewModel.init(widget.boredEntity);
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
                  fontSize: 12.sp,
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
              child: Icon(
                Icons.refresh,
                size: 26.w,
                color: Color(0xFFA0AFC6),
              ),
            ),
            onTap: _viewModel.loadData,
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
                Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  elevation: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.w,
                      horizontal: 6.w,
                    ),
                    width: double.maxFinite,
                    child: Text(
                      model.boredEntity?.activity ?? "Loading",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 50.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.w,
                ),
              ],
            );
          },
        ),
      );
}
