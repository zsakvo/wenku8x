// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ListBookTile(context,
    {required String cover,
    required String name,
    required String desc1,
    String? desc2,
    String? desc3,
    Function? onTap}) {
  var descSize = 25.sp;
  var titleSize = 30.sp;
  if (desc3 != null) {
    descSize = 22.sp;
    titleSize = 26.sp;
  }
  return InkWell(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
      child: Row(children: [
        CachedNetworkImage(
          imageUrl: cover,
          width: 124.w,
          height: 180.w,
          fit: BoxFit.cover,
        ),
        Expanded(
            child: Container(
          height: 180.w,
          padding: EdgeInsets.only(left: 32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: desc3 != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: titleSize,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              )),
              Text(
                desc1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: descSize,
                    height: 1.4,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5)),
              ),
              desc2 != null
                  ? Text(
                      desc2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: descSize,
                          height: 1.4,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.5)),
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
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.5)),
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
  );
}
