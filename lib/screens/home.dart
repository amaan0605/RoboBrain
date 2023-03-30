import 'package:ai_magic/screens/chat_screen.dart';
import 'package:ai_magic/utils/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController homeTextController = TextEditingController();
  int selectedCard = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        toolbarHeight: 80,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "RoboBrain",
            style: TextStyle(fontSize: 28),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 10.0),
            child: Text(
              'Choose an Avatar',
              style: textStyle,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: backgroundColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GridView.builder(
                      itemCount: 16,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              crossAxisCount: 4),
                      itemBuilder: (context, index) {
                        int number = index + 1;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCard = index;
                            });
                          },
                          child: selectedCard == index
                              ? const CircleAvatar(
                                  backgroundColor: Colors.greenAccent,
                                  child: Icon(
                                    Icons.check,
                                    color: backgroundColor,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/avatars/256_$number.png'),
                                ),
                        );
                      }),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    'Enter Your Name',
                    style: textStyle,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: backgroundColor.withOpacity(0.7),
                    ),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: homeTextController,
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.white30),
                          hintText: 'Enter your Name...',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: backgroundColor),
                  onPressed: () {
                    if (homeTextController.text.isEmpty || selectedCard == -1) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please Enter Your Name & Avatar!!'),
                        duration: Duration(seconds: 1),
                        backgroundColor: backgroundColor,
                      ));
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                  number: selectedCard + 1,
                                  userName: homeTextController.text,
                                )),
                      );
                    }
                  },
                  child: const Text(
                    "Let's Go!",
                  ),
                ),
              ],
            ),
          ),
          const Text(
            "Created by Amanullah",
          ),
          const SizedBox(height: 20.0)
        ]),
      ),
    );
  }
}
