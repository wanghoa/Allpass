import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:allpass/ui/allpass_ui.dart';
import 'package:allpass/util/screen_util.dart';
import 'package:allpass/model/data/card_bean.dart';
import 'package:allpass/model/data/password_bean.dart';
import 'package:allpass/provider/card_provider.dart';
import 'package:allpass/provider/password_provider.dart';
import 'package:allpass/provider/theme_provider.dart';
import 'package:allpass/page/card/card_widget_item.dart';
import 'package:allpass/page/password/password_widget_item.dart';
import 'package:allpass/widget/common/nodata_widget.dart';

class ClassificationDetailsPage extends StatelessWidget {

  final ScrollController _controller = ScrollController();

  final String type;
  ClassificationDetailsPage(this.type);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          splashColor: Colors.transparent,
          child: Text(
            type,
            style: AllpassTextUI.titleBarStyle,
          ),
          onTap: () {
            _controller.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.linear);
          },
        ),
        centerTitle: true,
      ),
      backgroundColor: Provider.of<ThemeProvider>(context).specialBackgroundColor,
      body: _getListView(context, _controller),
    );
  }

  Widget _getListView(BuildContext context, ScrollController controller) {
    List<Widget> all = List();
    List<Widget> list1 = List();
    List<Widget> list2 = List();
    List<PasswordBean> passwordList = Provider.of<PasswordProvider>(context).passwordList;
    for (int index = 0; index < passwordList.length; index++) {
      try {
        if (passwordList[index].folder == type) {
          list1.add(PasswordWidgetItem(index));
        }
      } catch (e) {
      }
    }
    List<CardBean> cardList = Provider.of<CardProvider>(context).cardList;
    for (int index = 0; index < cardList.length; index++) {
      try {
        if (type == cardList[index].folder) {
          list2.add(SimpleCardWidgetItem(index));
        }
      } catch (e) {
      }
    }
    if (list1.length == 0 && list2.length == 0) {
      return NoDataWidget(null);
    }
    all.add(Padding(
      padding: EdgeInsets.symmetric(vertical: AllpassScreenUtil.setHeight(10)),
    ));
    all.add(Card(
      margin: AllpassEdgeInsets.settingCardInset,
      elevation: 0,
      child: Column(
        children: list1,
      ),
    ));
    all.add(Card(
      margin: AllpassEdgeInsets.settingCardInset,
      elevation: 0,
      child: Column(
        children: list2,
      ),
    ));
    all.add(Padding(
      padding: EdgeInsets.symmetric(vertical: AllpassScreenUtil.setHeight(10)),
    ));
    return ListView(
      children: all,
      controller: controller,
    );
  }
}