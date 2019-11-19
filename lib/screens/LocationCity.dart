import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:weather/common/colors.dart';
import 'package:weather/screens/Weather.dart';
import 'package:weather/utils/Fade.dart';
import 'package:weather/utils/Ripple.dart';

class LocationCity extends StatefulWidget {
  @override
  _LocationCityState createState() => _LocationCityState();
}

class _LocationCityState extends State<LocationCity> {
  String text;
  Ripple ripple = Ripple();
  final Duration animationDuration = Duration(milliseconds: 500);
  final Duration delay = Duration(milliseconds: 0);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

  void _onTap() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  }

  void _goToNextPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(
            page: Weather(
          text: text,
        )))
        .then((_) => setState(() => rect = null));
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Text(
                          'WEATHER',
                          style: TextStyle(
                            color: Colors.black,
                              fontSize: 50, fontWeight: FontWeight.bold),
                        )),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFffffff),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            )),
                        hintText: 'CityName',
                        prefixText: ' ',
                      ),
                      onChanged: (value) {
                        text = value;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 15),
                    ),
                    RectGetter(
                      key: rectGetterKey,
                      child: FlatButton(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        color: buttonColor,
                        splashColor: Colors.blueAccent,
                        onPressed: _onTap,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Text(
                          'Get Weather',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        ripple.ripple(rect, animationDuration, context),
      ],
    );
  }
}
