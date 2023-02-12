//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shared_Pref extends StatefulWidget {
  const Shared_Pref({Key? key}) : super(key: key);

  @override
  State<Shared_Pref> createState() => _Shared_PrefState();
}

class _Shared_PrefState extends State<Shared_Pref> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _loadCounter();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _loadCounter() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
    });
  }

  void _incrementCounter() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Shared Preferences",
        style: TextStyle(
          color: Colors.white,
        ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes
      // auto-formatting nicer for build methods.
    );
  }
}


class Helper {
  static String valueSharedPreferences = "";

  static Future<bool> saveUserData(value) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setInt(valueSharedPreferences, value);
  }

  static Future getUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getInt(valueSharedPreferences);
  }
}