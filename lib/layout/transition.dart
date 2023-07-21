import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project_app/layout/cubit/cubit.dart';
import 'package:graduation_project_app/layout/cubit/states.dart';
import 'package:graduation_project_app/shared/style/colors.dart';

class Trans extends StatefulWidget {
  const Trans({super.key});

  @override
  State<Trans> createState() => _TransState();
}

class _TransState extends State<Trans> {
  DateTime currentBackPressTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (MainCubit.get(context).currentindex == 0) {
            DateTime now = DateTime.now();
            if (currentBackPressTime == null ||
                now.difference(currentBackPressTime) > Duration(seconds: 2)) {
              currentBackPressTime = now;
              Fluttertoast.showToast(msg: 'Press back again to exit');
              return Future.value(false);
            }
            exit(0);
          } else {
            MainCubit.get(context).changeNavbarIndex(0);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const Trans()),
                ));
            return false;
          }
        },
        child: BlocConsumer<MainCubit, MainStates>(
          listener: (BuildContext context, MainStates MainStates) {},
          builder: (BuildContext context, MainStates MainStates) {
            MainCubit cubit = MainCubit.get(context);
            return Scaffold(
              body: cubit.screens[cubit.currentindex],
              bottomNavigationBar: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: BottomNavigationBar(
                  currentIndex: cubit.currentindex,
                  onTap: (index) {
                    cubit.changeNavbarIndex(index);
                  },
                  items: const [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: Icon(Icons.home),
                    ),
                    BottomNavigationBarItem(
                      label: 'Live Location',
                      icon: Icon(Icons.gps_fixed),
                    ),
                    BottomNavigationBarItem(
                      label: 'My Tickets',
                      icon: Icon(Icons.history),
                    ),
                    BottomNavigationBarItem(
                      label: 'Profile',
                      icon: Icon(Icons.person),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
