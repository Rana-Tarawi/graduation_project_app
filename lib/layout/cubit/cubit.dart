import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_app/layout/cubit/states.dart';
import 'package:graduation_project_app/modules/Profile/profile_screen.dart';
import 'package:graduation_project_app/modules/Ticket/allTickets.dart';
import 'package:graduation_project_app/modules/live_location/checkTrain.dart';
import 'package:graduation_project_app/shared/variables.dart';

import '../../modules/home_screen/home_screen.dart';
class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainIntialState());
  static MainCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;
  final screens = [
    const HomeScreen(),
    CheckTrain(date:dateTicket, isFromHome: true,station: station),
    const TicketsView(),
    const ProfileScreen(),
  ];

  void changeNavbarIndex(index) {
    currentindex = index;
    emit(ChangeNavBarState());
  }
}
