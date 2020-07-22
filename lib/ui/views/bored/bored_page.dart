import 'package:bored/consts/config_constants.dart';
import 'package:bored/generated/l10n.dart';
import 'package:bored/models/bored_entity.dart';
import 'package:bored/ui/views/bored/bored_todo_item.dart';
import 'package:bored/view_models/bored_page_view_model.dart';
import 'package:bored/view_models/app_view_model.dart';
import 'package:bored/consts/asset_constants.dart';
import 'package:bored/service_locator.dart';
import 'package:bored/ui/widget/progress_bar.dart';
import 'package:bored/utils/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class BoredPage extends StatefulWidget {
  BoredPage({Key key, this.boredEntity}) : super(key: key);

  final BoredEntity boredEntity;

  @override
  _BoredPageState createState() => _BoredPageState();
}

class _BoredPageState extends State<BoredPage> with TickerProviderStateMixin {
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
          addAutomaticKeepAlives: true,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 16.w,
          ),
          shrinkWrap: false,
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
            Stack(
              children: <Widget>[
                ChangeNotifierProvider.value(
                  value: _viewModel,
                  child: Consumer<BoredPageViewModel>(
                    builder: (ctx, model, child) {
                      return Offstage(
                        offstage: model.collectList.length != 0,
                        child: _emptyWidget,
                      );
                    },
                  ),
                ),
                _todoListWidget,
              ],
            ),
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
    _viewModel.loadTodoList();
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                ConfigConstants.appName(context),
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
                DateUtil.formatDate(context,
                    Provider.of<AppViewModel>(context, listen: false).locale),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.w),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.w),
              child: Container(
                alignment: Alignment.center,
                width: 38.w,
                height: 38.w,
                child: SvgPicture.asset(
                  AssetConstants.systemSvg,
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                  width: 28.w,
                  height: 28.w,
                ),
              ),
              onTap: () => _viewModel.goSettingPage(context),
            ),
          ),
        ],
      );

  Widget get _activityHeader => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            S.of(context).activity,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(20.w),
                child: SizedBox(
                  width: 34.w,
                  height: 34.w,
                  child: Icon(
                    Icons.add,
                    size: 26.w,
                    color: Color(0xFFA0AFC6),
                  ),
                ),
                onTap: () => _viewModel.collectBored(),
              ),
              SizedBox(
                width: 6.w,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20.w),
                child: SizedBox(
                  width: 34.w,
                  height: 34.w,
                  child: RotationTransition(
                    turns: _curve,
                    child: Icon(
                      Icons.refresh,
                      size: 24.w,
                      color: Color(0xFFA0AFC6),
                    ),
                  ),
                ),
                onTap: () => _viewModel.loadData(_refreshAnimationCtl),
              ),
            ],
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
                          horizontal: 8.w,
                        ),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            AnimatedSize(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.linear,
                              vsync: this,
                              child: SizedBox(
                                width: double.maxFinite,
                                child: Text(
                                  model.boredEntity?.activity ??
                                      S.of(context).loading,
                                  style: TextStyle(
                                    color: Provider.of<AppViewModel>(context)
                                            .isDark(context)
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
                                descTextWidget(S.of(context).accessibility),
                                SizedBox(
                                  width: 10.w,
                                ),
                                ProgressBar(
                                  size: Size(200.w, 6.w),
                                  borderRadius: BorderRadius.circular(6.w),
                                  value: model.boredEntity?.accessibility !=
                                              null &&
                                          model.boredEntity.accessibility
                                              .isNotEmpty
                                      ? double.parse(
                                          model.boredEntity?.accessibility)
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
                                descTextWidget(S.of(context).price),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  descTextWidget(S.of(context).participants),
                                  Expanded(
                                    child: ListView(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
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
                                              color:
                                                  Theme.of(context).hintColor,
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
        S.of(context).todoList,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w800,
        ),
      );

  Widget get _todoListWidget => AnimatedList(
        key: _viewModel.listKey,
        padding: EdgeInsets.only(bottom: 20.w, top: 4.w),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (ctx, index, animation) {
          return TodoItem(
            todoEntity: _viewModel.collectList[index],
            animation: animation,
            onClickItem: () => _viewModel.showBoredDialog(context, index),
          );
        },
        initialItemCount: _viewModel.collectList.length,
      );

  Widget get _emptyWidget => Container(
        height: 300.w,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/svg/empty.svg",
              width: 80.w,
              height: 60.w,
            ),
            SizedBox(
              height: 30.w,
            ),
            Text(
              S.of(context).emptyHint,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      );
}
