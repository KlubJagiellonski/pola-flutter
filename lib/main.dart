import 'package:flutter/material.dart';

void main() {
  runApp(PolaApp());
}

class PolaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PolaApp',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(title: 'PolaApp zabierz mnie na zakupy'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> companies = <String>['A', 'B', 'C', 'D', 'F', 'E', 'G'];

  void _checkEanCode() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(32.0),
              child:
                  const Text('Sprawdź produkt na podtawie naszje wyszukiwarki'),
            ),
            Padding(
              padding: EdgeInsets.all(32.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter EAN number',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter any EAN number';
                  }
                  return null;
                },
              ),
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: companies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Center(child: Text('${companies[index]}')),
                  );
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _checkEanCode,
        tooltip: 'Search',
        child: Icon(Icons.search),
      ),
    );
  }
}
