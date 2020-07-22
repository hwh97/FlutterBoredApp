import 'package:bored/generated/l10n.dart';
import 'package:bored/service_locator.dart';
import 'package:bored/view_models/app_view_model.dart';
import 'package:bored/view_models/setting_page_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  final SettingPageViewModel _settingPageViewModel =
      serviceLocator.get<SettingPageViewModel>();

  @override
  Widget build(BuildContext context) {
    _settingPageViewModel.loadVersionInfo(context);
    _settingPageViewModel.loadItems(context);
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Provider.of<AppViewModel>(context).isDark(context)
          ? Color(0xFF0D0D0D)
          : Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          ChangeNotifierProvider.value(
            value: _settingPageViewModel,
            child: Consumer<SettingPageViewModel>(
              builder: (ctx, model, child) {
                return SliverPadding(
                  padding: EdgeInsets.only(top: 16.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((ctx, index) {
                      return SettingItem(
                        settingItemModel: model.items[index],
                      );
                    }, childCount: model?.items?.length ?? 0),
                  ),
                );
              },
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: EdgeInsets.only(bottom: 15.w),
              alignment: Alignment.bottomCenter,
              child: ChangeNotifierProvider.value(
                value: _settingPageViewModel,
                child: Consumer<SettingPageViewModel>(
                  builder: (ctx, model, child) {
                    return Text(
                      model.version,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.sp,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return AppBar(
      leading: Align(
        alignment: Alignment.center,
        child: InkWell(
          borderRadius: BorderRadius.circular(30.w),
          onTap: () => Navigator.maybePop(context),
          child: Padding(
            padding: EdgeInsets.all(6.w),
            child: Icon(
              Icons.arrow_back,
              size: 26.w,
              color: primaryColor,
            ),
          ),
        ),
      ),
      elevation: 0,
      backgroundColor: Provider.of<AppViewModel>(context).isDark(context)
          ? Color(0xFF0D0D0D)
          : Colors.white,
      bottom: PreferredSize(
        child: Container(
          alignment: Alignment.centerLeft,
          color: Provider.of<AppViewModel>(context).isDark(context)
              ? Color(0xFF0D0D0D)
              : Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
          child: Text(
            S.of(context).settings,
            style: TextStyle(
              color: primaryColor,
              fontSize: 28.sp,
            ),
          ),
        ),
        preferredSize: Size.fromHeight(54.w),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final SettingItemModel settingItemModel;

  const SettingItem({Key key, this.settingItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: settingItemModel.onTap,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 12.w),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      settingItemModel.title,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 6.w,
                    ),
                    Text(
                      settingItemModel.subTitle,
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 12.sp,
                      ),
                    )
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.w,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          Divider(
            height: 1.w,
          ),
        ],
      ),
    );
  }
}
