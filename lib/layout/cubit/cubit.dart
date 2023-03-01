import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_app/layout/cubit/states.dart';
import 'package:graduation_project_app/modules/Profile/profile_screen.dart';
import 'package:graduation_project_app/modules/Ticket/allTickets.dart';
import 'package:graduation_project_app/modules/Ticket/timeFuns.dart';
import 'package:graduation_project_app/modules/live_location/checkTrain.dart';
import 'package:graduation_project_app/shared/variables.dart';
import 'package:graduation_project_app/widgets/global.dart';

import '../../modules/home_screen/home_screen.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainIntialState());
  static MainCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;
  final screens = [
    const HomeScreen(),
    CheckTrain(date: dateTicket, isFromHome: true, station: station),
    const TicketsView(),
    const ProfileScreen(),
  ];

  void changeNavbarIndex(index) {
    currentindex = index;
    emit(ChangeNavBarState());
  }

//   Future<void> update() async {
//     String dateTobBeDeleted =
//         newDateTime(DateTime.now().toString(), "23:59:59");
//     final Map<String, dynamic> deletes = {
//       dateTobBeDeleted: FieldValue.delete(),
//     };
//     List<bool> seats = List.filled(48, false);
//     String dateTobBeSet = newDateTime(
//         DateTime.now().add(const Duration(days: 7)).toString(), "23:59:59");
//     final Map<String, dynamic> sets = {
//       dateTobBeSet: seats,
//     };
//     FirebaseFirestore.instance
// .collection("trains")
//         .doc("2dRl1WJljsXJpNrn9KYB")
//         .collection("seats")
//         .get().then((value) {value.docs.forEach((element) { element.update(deletes)
//         .then((value) {
//       FirebaseFirestore.instance
//         .collection("trains")
//           .doc("2dRl1WJljsXJpNrn9KYB")
//           .collection("seats")
//           .set(sets, SetOptions(merge: true));
//     })})})
//         .catchError((error) {
//       ResetSeatsErrorState(error.toString());
//     });
//   }

//   Future<void> resetSeats() async {
//     bool isexist = false;
//     bool isexpired = false;
//     FirebaseFirestore.instance
//     .collection("trains")
//         .doc("2dRl1WJljsXJpNrn9KYB")
//         .collection("seats")
//         .get()
//         .then((value) {
//        value.docs.forEach((element) {isexist = element.data().containsKey(newDateTime(DateTime.now().toString(), "23:59:59"));
//       if (isexist) {
//         isexpired = expired(
//             DateTime.parse(newDateTime(DateTime.now().toString(), "23:59:59")));
//       }
//     });}).catchError((error) {
//      emit(CheckSeatsErrorState(error.toString())) ;
//     });

//     if (isexpired) {
//       update().then((value) {
//         emit(ResetSeatsSuccessState());
//       }).catchError((error) {
//         emit(ResetSeatsErrorState(error.toString()));
//       });
//     }
//   }

  bool isexist = false;
  bool isexpired = false;
  List trainsDocs = [
    '2dRl1WJljsXJpNrn9KYB',
    'Ch6XjXxzROUKj43a5514',
    'GJKZ8iQI7y0gH5xygXHv',
    'Hqxznuod9XaQenF75gRK',
    'IPg76Z4TtDCiLVQHTtEq',
    'JRFxN6jiIpQZ8QTcvCVt',
    'OYWMTz9e7yENbM0LOyc2',
    'QSyYEPvr85riNoFYBPZJ',
    'XkhKKO2QTJ6XDNfpDXya',
    'g5rWOLNbdr6NLEPJrpbQ',
    'jIL4UEv90x7ESzT0ksXV',
    'jevKCjY8iFVkwpxhjw0n',
    'rA23Dfb4AeaZ1Ds2jvQQ',
    'sBEBaFUWFaiSNcw1TJDu',
    'sGqWFjS3syqizW4EZlVY',
    'tn2ILzqjjm3GtYtPgrwj',
    'wEdjQtfgZagcN02PRRfY'
  ];

  Future<void> checkExpiredDate() async {
    await FirebaseFirestore.instance
        .collection("trains")
        .doc("2dRl1WJljsXJpNrn9KYB")
        .collection("seats")
        .doc('2I3TxQ3Hmrs4cpwfmQhH')
        .get()
        .then((value) {
      isexist = value
          .data()!
          .containsKey(newDateTime(DateTime.now().toString(), "06:59:59"));
      print("isexist");
      print(isexist);
      if (isexist) {
        isexpired = expired(
            DateTime.parse(newDateTime(DateTime.now().toString(), "06:59:59")));
        print("isexpired");
        print(isexpired);
      }
    });
  }

  Future<void> update() async {
    //اكتبي هنا يا ندود
    // ده كود الماب بتاعة التاريخ الللي هيتمسح واللي هيتحط اللي هتديها لفانكشن
    // update(deletes) / set(sets, SetOptions(merge: true))
    String dateTobBeDeleted =
        newDateTime(DateTime.now().toString(), "06:59:59");
    final Map<String, dynamic> deletes = {
      dateTobBeDeleted: FieldValue.delete(),
    };
    List<bool> seats = List.filled(48, false);
    String dateTobBeSet = newDateTime(
        DateTime.now().add(const Duration(days: 7)).toString(), "23:59:59");
    final Map<String, dynamic> sets = {
      dateTobBeSet: seats,
    };
    await FirebaseFirestore.instance
        .collection('trains')
        .doc("2dRl1WJljsXJpNrn9KYB")
        .collection("seats")
        .doc('Lzmj2kh4n6gIQMQwu4sU')
        .update({
      '2023-03-06 23:59:59': FieldValue.delete(),
    }).whenComplete(() async {
      print('Field deleted');
      emit(DeleteFieldState());
      await FirebaseFirestore.instance
          .collection('trains')
          .doc('2dRl1WJljsXJpNrn9KYB')
          .collection("seats")
          .doc('Lzmj2kh4n6gIQMQwu4sU')
          .set({'2023-03-06 23:59:59': seats}, SetOptions(merge: true)).then(
              (value) async {
        //Do your stuff.
        print('the field added successfully');
        emit(AddFieldState());
}).catchError((error) {
        print(error.toString());
        emit(DeleteFieldErrorState(error));
      });
    });
  }

  Future<void> resetSeats() async {
    isexist = false;
    isexpired = false;
    update();
    checkExpiredDate().then((value) {
      print("isexist & isexpired");
      print(isexist & isexpired);
      
      //كملي هنا بقا ياندود بعد ماتظبطي الفانكشن اللي فوق
      // اعملي ليستيتين بقا فيهم عنوايين الدوكس بتاعة الترينز والسيتس وظبطي الدنيا يعني انه يعمل فور لوب
      // على فانكشن ال update
      // ويديها كل مرة الاندكس بتاع عنوان الترين والسيتس
      emit(CheckExpiredDateSuccesState());
    }).catchError((error) {
      emit(CheckExpiredDateErrorState(error.toString()));
    });
  }
}
