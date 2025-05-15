import 'package:finance_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/change_language_cubit/change_language_cubit.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,

    this.userName,
  });


  final String? userName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        userName != null
            ? S.of(context).welcome_name(userName!)
            : S.of(context).welcome_title,
        style: const TextStyle(fontSize: 20),
      ),
      actions: [
        //         IconButton(
        //   icon: Icon(
        //     Icons.notifications,
        //   ),
        //   onPressed: (){
        //     Navigator.pushNamed(context, NotificationView.routeName);
        //   },
        // ),

      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
