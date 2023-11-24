import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            background: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String label = "No data";
  var httpfuture = http.get(Uri.parse("http://numbersapi.com/random/math"));
  /*another way to declare
          var httpfuture = http.get(Uri.http("numbersapi.com","/random/math"));
          */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent.shade200,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Ubicaciones'),
            ),
            ListTile(
              title: const Text('Barra'),
              onTap: () {
                // ..
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Sala'),
              onTap: () {
                //..
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(50),
              child: FutureBuilder(
                future: httpfuture,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data?.body ?? "No data",
                        style: const TextStyle(color: Colors.white, fontSize: 25));
                  } else if (snapshot.hasError) {
                    return Text("Error: $Error");
                  } else {
                    return const CircularProgressIndicator();
                  }
                })
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //label = "Requesting...";
          //setState(() {});
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => widget));
          /*future.then((response) {
            label = response.body;
            setState(() {});
          }).catchError((error) {
            label = "Error: ${error.toString()}";
            setState(() {});
          });*/
        },
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

