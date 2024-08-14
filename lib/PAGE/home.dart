import 'package:flutter/material.dart';
import 'package:addhills_app/PAGE/TOP_BUTTONS/top_iconbuttons.dart';
//import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 16, 16),
      drawer: const Menu(),
      body: Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MenuNotifProfile(),
              const Padding(
                padding: EdgeInsets.only(
                  top: 200,
                  right: 80,
                ),
                child: Column(
                  children: [
                    Text(
                      'WELCOME,\nUSER 01',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        letterSpacing: 2,
                        color: Color.fromARGB(255, 201, 43, 32),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        left: 80,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'How can i help you?',
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.white38,
                            ),
                          ),
                          SearchBar(
                            constraints: BoxConstraints(minHeight: 35),
                            leading: Icon(Icons.search),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
