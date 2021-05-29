import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:good_reminder/models/db_wrapper.dart';
import 'package:good_reminder/utils/utils.dart';

class Popup extends StatelessWidget {
  final Function getTodosAndDones;

  Popup({this.getTodosAndDones});

  @override
  Widget build(BuildContext context) {
    String appUrl = Utils.getPlatformSpecificUrl('Hola a todos');
    String portfolioUrl = Utils.getPlatformSpecificUrl('Hola a todos');

    return PopupMenuButton<int>(
        elevation: 4,
        icon: Icon(Icons.more_vert),
        onSelected: (value) {
          print('Selected value: $value');
          if (value == kMoreOptionsKeys.clearAll.index) {
            Utils.showCustomDialog(context,
                title: 'Are you sure?',
                msg: 'All done todos will be deleted permanently',
                onConfirm: () {
              DBWrapper.sharedInstance.deleteAllDoneTodos();
              getTodosAndDones();
            });
          } else if (value == kMoreOptionsKeys.moreApps.index) {
            Utils.launchURL(portfolioUrl);
          } else if (value == kMoreOptionsKeys.about.index) {
            Utils.launchURL("https://www.youtube.com");
          } else if (value == kMoreOptionsKeys.writeReview.index) {
            Utils.launchURL(appUrl);
          } else if (value == kMoreOptionsKeys.shareApp.index) {
            Share.share('Check out this awesome app ' + appUrl);
          } else if (value == kMoreOptionsKeys.followUs.index) {
            Utils.launchURL("https://www.youtube.com");
          }
        },
        itemBuilder: (context) {
          List list = List<PopupMenuEntry<int>>.empty(growable: true);

          for (int i = 0; i < kMoreOptionsMap.length; ++i) {
            list.add(PopupMenuItem(value: i, child: Text(kMoreOptionsMap[i])));

            if (i == 0) {
              list.add(PopupMenuDivider(
                height: 5,
              ));
            }
          }

          return list;
        });
  }
}