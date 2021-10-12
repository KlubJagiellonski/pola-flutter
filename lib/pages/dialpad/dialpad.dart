import 'package:flutter/material.dart';

class DialPadPage extends StatefulWidget {
  const DialPadPage({Key? key}) : super(key: key);

  @override
  _DialPadPageState createState() => _DialPadPageState();
}

class _DialPadPageState extends State<DialPadPage> {
  late String ean = "";

  @override
  void initState() {
    super.initState();
    ean = "";
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontWeight: FontWeight.normal, fontSize: 60.0, color: Colors.black);

    return Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(ean,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 40.0,
                          color: Colors.red[700]))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          {
                            ean = ean + "1";
                          }
                        });
                      },
                      child: const Text('1', style: textStyle)),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          {
                            ean = ean + "2";
                          }
                        });
                      },
                      child: const Text('2', style: textStyle)),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          {
                            ean = ean + "3";
                          }
                        });
                      },
                      child: const Text('3', style: textStyle))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          {
                            ean = ean + "4";
                          }
                        });
                      },
                      child: const Text('4', style: textStyle)),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          {
                            ean = ean + "5";
                          }
                        });
                      },
                      child: const Text('5', style: textStyle)),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          {
                            ean = ean + "6";
                          }
                        });
                      },
                      child: const Text('6', style: textStyle))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          {
                            ean = ean + "7";
                          }
                        });
                      },
                      child: const Text('7', style: textStyle)),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          {
                            ean = ean + "8";
                          }
                        });
                      },
                      child: const Text('8', style: textStyle)),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          {
                            ean = ean + "9";
                          }
                        });
                      },
                      child: const Text('9', style: textStyle))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          {
                            if (ean.length >= 2) {
                              ean = ean.substring(0, ean.length - 1);
                            }
                            if (ean.length == 1) {
                              ean = "";
                            }
                          }
                        });
                      },
                      child: const Text('<', style: textStyle)),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          {
                            ean = ean + "0";
                          }
                        });
                      },
                      child: const Text('0', style: textStyle)),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, ean);
                      },
                      child: const Text('x', style: textStyle))
                ],
              )
            ],
          )),
        ));
  }
}
