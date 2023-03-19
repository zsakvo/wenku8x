// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget ListBookTile(context,
    {required String cover,
    required String name,
    required String desc1,
    String? desc2,
    String? desc3,
    Function? onTap,
    Function? onLongTap}) {
  var descSize = 13.0;
  var titleSize = 16.0;
  if (desc3 != null) {
    descSize = 12.0;
    titleSize = 14.0;
  }
  return InkWell(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(children: [
        CachedNetworkImage(
          imageUrl: cover,
          width: 76,
          height: 110,
          fit: BoxFit.cover,
        ),
        Expanded(
            child: Container(
          height: 110,
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: titleSize,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              Text(
                desc1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: descSize,
                    height: 1.4,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
              ),
              desc2 != null
                  ? Text(
                      desc2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: descSize,
                          height: 1.4,
                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                    )
                  : const SizedBox.shrink(),
              desc3 != null
                  ? Text(
                      desc3,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: descSize,
                          height: 1.4,
                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ))
      ]),
    ),
    onTap: () {
      if (onTap != null) {
        onTap();
      }
    },
    onLongPress: () {
      if (onLongTap != null) {
        onLongTap();
      }
    },
  );
}
