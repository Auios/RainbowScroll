import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin<HomePage> {
  late ScrollController scrollController;
  final Random random = Random(1);
  bool showBackToTopButton = false;
  Color foregroundColor = Colors.white;
  Color backgroundColor = Colors.black;
  double scrollOffset = 0;

  final List<String> colorNames = <String>[
      'red',
      'pink',
      'purple',
      'deepPurple',
      'indigo',
      'blue',
      'lightBlue',
      'cyan',
      'teal',
      'green',
      'lightGreen',
      'lime',
      'yellow',
      'amber',
      'orange',
      'deepOrange',
      'brown',
      'blueGrey',
    ];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(scrollUpdate);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollUpdate() {
    setState(() {
      showBackToTopButton = scrollController.offset >= 1000;
      scrollOffset = scrollController.offset;
    });
  }

  void scrollToTop() {
    scrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.easeOutQuint);
  }

  Color randomColor() {
    return Colors.primaries[random.nextInt(Colors.primaries.length)];
  }

  String capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        title: Text('Rainbow Scroll: ${scrollOffset.toStringAsFixed(2)}'),
      ),
      body: ListView.builder(
        controller: scrollController,
        addAutomaticKeepAlives: false,
        itemBuilder: (_, index)
        {
          return Container(
            //color: randomColor(),
            color: Colors.primaries[index % Colors.primaries.length],
            height: 200,
            child: Text(capitalize(colorNames[index % Colors.primaries.length]), style: const TextStyle(color: Colors.white, fontSize: 35)),
            alignment: Alignment.center,
          );
        }
      ),
      floatingActionButton: showBackToTopButton == false
      ? null
      : FloatingActionButton(
        onPressed: scrollToTop,
        child: const Icon(Icons.arrow_upward),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
    );
  }
}
