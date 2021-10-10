import 'package:bottomnavigationbar/bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: MyBottomNavigationBar(myWidth: 300)),
        // bottomNavigationBar: MyBottomNavigationBar(myWidth: 300),
      ),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  final double myWidth;
  const MyBottomNavigationBar({Key? key, this.myWidth: 10}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar>
    with TickerProviderStateMixin {
  bool change = false;
  double x = 0;
  //

  MyBlocTest bloc = MyBlocTest();
  //
  late AnimationController _controller;
  late Animation anim1;
  late Animation anim2;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    anim1 = CurveTween(
      curve: Interval(
        0.0,
        0.5,
        curve: Curves.linear,
      ),
    ).animate(_controller);

    anim2 = CurveTween(
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.linear,
      ),
    ).animate(_controller);

    _controller.addListener(() {
      setState(() {
        print("x ::: $x");
        x = _controller.value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // _controller
        //     .forward(from: 0.0)
        //     .then((value) => _controller.reverse().then((value) {
        //           print("Changing State");
        //           bloc.start();

        //           change = false;
        //         }));
        change = true;
        _controller.forward();

        // setState(() {
        //   change = true;
        // });

        // await Future.delayed(Duration(seconds: 1));
        // setState(() {
        //   change = false;
        // });
      },
      child: SafeArea(
        child: ListView.builder(
            itemCount: 200,
            itemBuilder: (context, i) {
              return CustomTile(
                x: 0,
                y: 100,
                duration: Duration(seconds: 1),
                child: Container(
                  color: Colors.amber,
                  margin: EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    title: Text("afd"),
                    subtitle: Text("dffds"),
                  ),
                ),
              );
            }),
      ),

      // Container(
      //   height: double.infinity,
      //   width: double.infinity,
      //   child: AnimatedBuilder(
      //     animation: _controller,
      //     builder: (context, _) {
      //       final currentWidth =
      //           widget.myWidth - (anim1.value * 50) + (anim2.value * 50);
      //       // print("myWidth - ${widget.myWidth} currentWidth - $currentWidth");
      //       print("Anim 1 - ${anim1.value} ANnim 2 - ${anim2.value}");
      //       return Stack(
      //         fit: StackFit.expand,
      //         children: [
      //           Positioned(
      //             top: (MediaQuery.of(context).size.height / 2) +
      //                 (anim1.value * 50) +
      //                 (anim2.value * 50),
      //             left: 0,
      //             right: 0,
      //             child: SizedBox(
      //               height: kBottomNavigationBarHeight + 10,
      //               width: currentWidth,
      //               child: Opacity(
      //                 opacity: _controller.value,
      //                 child: bloc.state
      //                     ? Icon(Icons.headset_rounded)
      //                     : Icon(
      //                         Icons.headset_rounded,
      //                         color: Colors.red,
      //                       ),
      //               ),
      //             ),
      //           ),
      //           Positioned(
      //             bottom: 0,
      //             left: 0,
      //             right: 0,
      //             child: SizedBox(
      //               height: kBottomNavigationBarHeight + 10,
      //               width: currentWidth,
      //               child: ListView.builder(
      //                 scrollDirection: Axis.horizontal,
      //                 itemCount: 30,
      //                 itemBuilder: (context, i) {
      //                   return Transform.translate(
      //                     offset: Offset(i == 0 ? 0 : (i * 5), 0),
      //                     child: Icon(Icons.ac_unit),
      //                   );
      //                 },
      //               ),
      //             ),
      //           ),
      //           // Positioned(
      //           //   bottom: 100,
      //           //   left: MediaQuery.of(context).size.width / 2,
      //           //   child: AnimatedContainer(
      //           //     duration: Duration(seconds: 1),
      //           //     color: change ? Colors.amber : Colors.black,
      //           //     height: change ? 50 : 200,
      //           //     width: change ? 50 : 200,
      //           //     child: Text("sffa"),
      //           //   ),
      //           // ),

      //           AnimatedBuilder(
      //               animation: _controller,
      //               builder: (context, _) {
      //                 return Positioned(
      //                   top: 300 - _controller.value * 30,
      //                   left: 0,
      //                   right: 0,
      //                   child: Opacity(
      //                     opacity: (_controller.value),
      //                     child: Container(
      //                       color: change ? Colors.amber : Colors.black,
      //                       height: change ? 50 : 200,
      //                       width: change ? 50 : 200,
      //                       child: Text("sffa"),
      //                     ),
      //                   ),
      //                 );
      //               }),
      //         ],
      //       );
      //     },
      //   ),
      // ),
    );
  }
}

class CustomTile extends StatefulWidget {
  double x, y;
  Duration duration;
  late Widget child;
  CustomTile({
    this.x: 0,
    this.y: 0,
    this.duration: const Duration(seconds: 1),
    this.child: const Text("No Child Given"),
  });
  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _controller.addListener(() {
      setState(() {
        // print("x ::: ${widget.x}");
        widget.x = _controller.value;
      });
    });
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, snapshot) {
        return Opacity(
          opacity: widget.x,
          child: Transform.translate(
            offset: Offset(0, 100 - widget.x * 100),
            child: widget.child,
          ),
        );
      },
    );
  }
}
