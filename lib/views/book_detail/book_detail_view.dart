import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wenku8x/modals/book_meta.dart';

import 'book_detail_model.dart';

class BookDetailView extends StatefulHookConsumerWidget {
  final String aid;
  const BookDetailView(this.aid, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookDetailViewState();
}

class _BookDetailViewState extends ConsumerState<BookDetailView> {
  @override
  void initState() {
    super.initState();
    ref.read(bookIntroProvider.notifier).load(widget.aid);
  }

  @override
  Widget build(BuildContext context) {
    final BookMeta meta = ref.watch(bookMetaProvider);
    final String intro = ref.watch(bookIntroProvider);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 40.sp,
            ),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
          centerTitle: false,
          title: Transform.translate(
              offset: Offset(0, -2.sp),
              child: Text(
                widget.aid,
                style: TextStyle(fontSize: 32.sp),
              ))),
      body: Text(intro),
    );
  }
}
