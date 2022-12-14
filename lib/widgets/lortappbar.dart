import 'package:flutter/material.dart';
import 'package:sedil/utilities/lortime.dart';

class LORTAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Icon(Icons.headphones_rounded, color: Colors.black),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: ListenOrReadTimeWidget(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
