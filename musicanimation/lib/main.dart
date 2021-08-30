import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  List<Color> colors = [
    Colors.orangeAccent,
    Colors.red,
    Colors.yellow,
    Colors.black,
    Colors.blue,
  ];

  int selectedCardIndex = 0;

  double _slideValue = 0.0, _heightValue = 0.0;

  // _onChangedSlider(double slideValue) {
  //   setState(() {
  //     _slideValue = slideValue;
  //   });
  // }

  late AnimationController _animationController;
  late AnimationController _animationController2;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: Duration(
        milliseconds: 300,
      ),
    );

    _animationController2 = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    // _animation =
    //     Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.addListener(() {
      print("_slideValue - ${_animationController.value}");
      setState(() {
        _slideValue = _animationController.value.clamp(0.0, 1.0);
      });
    });

    _animationController2.addListener(() {
      print("_heightValue - ${_animationController2.value}");
      setState(() {
        _heightValue = _animationController2.value.clamp(0.0, 1.0);
      });
    });

    super.initState();
  }

  bool _firstAnimationStarted = false, _secondAnimationStarted = false;

  _cardSelected({int index: 0}) {
    print("Selected Index - $index");
    selectedCardIndex = index;
  }

  int heightDirection(int index) {
    return index == selectedCardIndex
        ? 0
        : selectedCardIndex < index
            ? 1
            : -1;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Animations",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: LayoutBuilder( 
            builder: (context, consraints) {
              return Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    if (_secondAnimationStarted) {
                      _secondAnimationStarted = false;
                      _animationController2.reverse().then((value) {
                        if (_firstAnimationStarted) {
                          print("reverse");
                          _firstAnimationStarted = false;
                          _animationController.reverse();
                        }
                      });
                    } else if (_firstAnimationStarted) {
                      print("reverse");
                      _firstAnimationStarted = false;
                      _animationController.reverse();
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    height: consraints.maxHeight,
                    width: consraints.maxWidth / 2.5,
                    child: GestureDetector(
                      onTap: () {
                        if (!_firstAnimationStarted) {
                          print("forward");
                          _firstAnimationStarted = true;
                          _animationController.forward();
                        }
                      },
                      child: Stack(
                        children: [
                          ...List.generate(
                            5,
                            (i) => Positioned(
                              top: _slideValue * 100 +
                                  (i * _slideValue * 65) +
                                  (heightDirection(i) * _heightValue * 120),
                              // + (consraints.maxHeight / 2 - 75),
                              // left: 0,
                              // right: 0,
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateX(_slideValue == 1.0
                                      ? !_secondAnimationStarted
                                          ? 13
                                          : 0
                                      : 0),
                                child: AbsorbPointer(
                                  absorbing: !_firstAnimationStarted,
                                  child: InkWell(
                                    onTap: () {
                                      if (_secondAnimationStarted) {
                                        _secondAnimationStarted = false;
                                        _animationController2
                                            .reverse()
                                            .then((value) {
                                          if (!_secondAnimationStarted &&
                                              selectedCardIndex != i) {
                                            _cardSelected(index: i);
                                            _secondAnimationStarted = true;
                                            _animationController2.forward();
                                          }
                                        });
                                      } else if (!_secondAnimationStarted) {
                                        _cardSelected(index: i);
                                        _secondAnimationStarted = true;
                                        _animationController2.forward();
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors[i % 5],
                                      ),
                                      height: 150,
                                      width: consraints.maxWidth / 2.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Slider(value: _slideValue, onChanged: _onChangedSlider),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
