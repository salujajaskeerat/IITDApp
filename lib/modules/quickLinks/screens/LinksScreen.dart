import 'package:IITDAPP/modules/quickLinks/data/LinksData.dart';
import 'package:IITDAPP/utility/UrlHandler.dart';
import 'package:IITDAPP/values/colors/colors.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

class LinksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Padding buildItem(var label) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 40),
        child: InkWell(
          onTap: () {
            UrlHandler.launchInBrowser(label.url);
          },
          child: Text(
            label.name,
            style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white),
          ),
        ),
      );
    }

    Column buildList(var value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 4,
          ),
          for (var i in value) buildItem(i),
          Container(
            height: 6,
          )
        ],
      );
    }

    const radius = 10.0;
    ExpandableNotifier LinksCard(String key, var value) {
      return ExpandableNotifier(
        controller: ExpandableController(initialExpanded: true),
//      initialExpanded: true,
        child: Padding(
          padding: const EdgeInsets.all(10),
//          child: Card(
//            color: Colors.white,
//            clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppColors.LinksSectionStart,
                      AppColors.LinksSectionEnd
                    ])),
            child: Column(
              children: <Widget>[
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToExpand: true,
                    tapBodyToCollapse: false,
                    hasIcon: false,
                  ),
                  header: Builder(builder: (context) {
                    var exp = ExpandableController.of(context);
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: !exp.expanded
                            ? BorderRadius.all(Radius.circular(radius))
                            : BorderRadius.only(
                                topLeft: Radius.circular(radius),
                                topRight: Radius.circular(radius)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            ExpandableIcon(
                              theme: const ExpandableThemeData(
                                expandIcon: Icons.arrow_right,
                                collapseIcon: Icons.arrow_drop_down,
                                iconColor: Colors.white,
                                iconSize: 28.0,
                                iconRotationAngle: math.pi / 2,
                                iconPadding: EdgeInsets.only(right: 5),
                                hasIcon: false,
                              ),
                            ),
                            Expanded(
                              child: Text(key,
                                  style: GoogleFonts.newsCycle(
                                      fontSize: 24, color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }), //dsakml
                  expanded: buildList(value),
                ),
              ],
            ),
          ),
//          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(children: [
        for (MapEntry e in linksData.entries) LinksCard(e.key, e.value),
        Container(
          height: 25,
        )
      ]),
    );
  }
}

class CustomBoxDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class abcd extends ExpandableController {
  @override
  bool get expanded => super.expanded;
}
