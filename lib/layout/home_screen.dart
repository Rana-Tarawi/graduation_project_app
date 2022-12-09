import 'package:flutter/material.dart';
import 'package:graduation_project_app/modules/trains_screen.dart';
import 'package:graduation_project_app/shared/style/colors.dart';
import 'package:graduation_project_app/shared/components/button.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  TextEditingController depart = TextEditingController();
  int travellers = 1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: colortheme.lightGray,
        body: SizedBox(
          width: width,
          height: height,
          child: Stack(children: [
            Container(
              width: width,
              height: height * 0.3,
              decoration: BoxDecoration(
                  color: colortheme.lightPurple,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(width * .1),
                    bottomRight: Radius.circular(width * .1),
                  )),
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Let\'s',
                            style: TextStyle(
                                color: colortheme.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Text('Book Your\nNext Trip ',
                            style: TextStyle(
                                color: colortheme.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ]),
                ),
              ]),
            ),
            Positioned(
              top: height * 0.22,
              left: width * 0.05,
              child: Container(
                width: width * .9,
                height: height * 0.65,
                decoration: BoxDecoration(
                    color: colortheme.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(width * .05),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                            controller: from,
                            cursorColor: colortheme.lightPurple,
                            decoration: InputDecoration(
                              labelText: 'From where?',
                              labelStyle:
                                  TextStyle(color: colortheme.lightPurple),
                              focusedBorder: UnderlineInputBorder(),
                            )),
                        TextFormField(
                            controller: to,
                            cursorColor: colortheme.lightPurple,
                            decoration: InputDecoration(
                              labelText: 'Where to?',
                              labelStyle:
                                  TextStyle(color: colortheme.lightPurple),
                              focusedBorder: UnderlineInputBorder(),
                            )),
                        TextFormField(
                            controller: depart,
                            cursorColor: colortheme.lightPurple,
                            decoration: InputDecoration(
                              hintText: '26 Sept, 2022',
                              labelText: 'Depart',
                              labelStyle:
                                  TextStyle(color: colortheme.lightPurple),
                              focusedBorder: UnderlineInputBorder(),
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Travellers',
                              style: TextStyle(
                                color: colortheme.lightPurple,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: width * 0.09,
                                  height: width * 0.09,
                                  decoration: BoxDecoration(
                                      color: colortheme.lightGray,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(width * .03),
                                      )),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (travellers == 0) {
                                          travellers = 0;
                                        } else {
                                          travellers--;
                                        }
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.remove,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Text(
                                  '$travellers',
                                  style: const TextStyle(
                                    color: colortheme.black,
                                    fontSize: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Container(
                                  width: width * 0.09,
                                  height: width * 0.09,
                                  decoration: BoxDecoration(
                                      color: colortheme.lightGray,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(width * .03),
                                      )),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        travellers++;
                                      });
                                    },
                                    icon:const Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        button(
                            text: 'Search Trains',
                            onpress: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => TrainsScreen(
                                        from: from.text,
                                        to: to.text,
                                        date: depart.text)),
                                  ),
                                ),
                            width: width * 0.5,
                            height: 60),
                      ]),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
