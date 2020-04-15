import 'package:bored/business_logic/view_models/bored_page_view_model.dart';
import 'package:bored/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoredPage extends StatefulWidget {
  BoredPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BoredPageState createState() => _BoredPageState();
}

class _BoredPageState extends State<BoredPage> {
  final BoredPageViewModel _viewModel =
      serviceLocator.get<BoredPageViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ChangeNotifierProvider(
          create: (context) => _viewModel,
          child: Consumer<BoredPageViewModel>(
            builder: (ctx, model, child) {
              return Text(
                model.boredEntity?.toJson()?.toString() ?? "loading",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _viewModel.loadData,
        tooltip: 'Refresh Task',
        child: Icon(Icons.refresh),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _viewModel.loadData();
  }
}
