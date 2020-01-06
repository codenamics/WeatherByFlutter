import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:weather/animations/FadeAnimation.dart';
import 'package:weather/screens/Weather.dart';
import 'package:weather/service/WeatherService.dart';
import 'package:weather/utils/Fade.dart';
import 'package:weather/utils/Ripple.dart';

class LocationCity extends StatefulWidget {
  @override
  _LocationCityState createState() => _LocationCityState();
}

class _LocationCityState extends State<LocationCity> {
  bool _isLoading = false;
  Rect rect;
  String text;
  Ripple ripple = Ripple();
  final Duration animationDuration = Duration(milliseconds: 500);
  final _form = GlobalKey<FormState>();
  final Duration delay = Duration(milliseconds: 0);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();

  void rippleRec(recKey) {
    setState(() => rect = RectGetter.getRectFromKey(recKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  }

  Future _onTap(cityName) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (cityName) {
      final isValid = _form.currentState.validate();

      if (!isValid) {
        return;
      }
      setState(() {
        _isLoading = true;
      });
      _form.currentState.save();
     await weatherByCityName(context, text);
      rippleRec(rectGetterKey);
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
       await weatherByLocation(context);
        rippleRec(rectGetterKey);
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Location service access denied'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _goToNextPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(page: Weather(text)))
        .then((_) => setState(() {
              rect = null;
              text = null;
            }));
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _isLoading
            ? Center(
                child: CircularProgressIndicator(
                key: rectGetterKey,
              ))
            : Center(
                child: Container(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          FadeAnimation(
                              1.1,
                              Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  child: Text(
                                    'WEATHER',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          FadeAnimation(
                              1.3,
                              Container(
                                margin: EdgeInsets.only(bottom: 30),
                                child: Form(
                                  key: _form,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please provide CityName';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      text = value;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(18),
                                      filled: true,
                                      fillColor: Color(0xFFffffff),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          )),
                                      hintText: 'CityName',
                                      prefixText: ' ',
                                    ),
                                  ),
                                ),
                              )),
                          FadeAnimation(
                              1.5,
                              Container(
                                  child: FlatButton(
                                padding: EdgeInsets.fromLTRB(0, 17, 0, 17),
                                color: Colors.blueAccent,
                                splashColor: Colors.blueAccent,
                                onPressed:
                                    _isLoading ? null : () => _onTap(true),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: _isLoading
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text(
                                        'Get Weather by CityName',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                              ))),
                          SizedBox(
                            height: 10,
                          ),
                          FadeAnimation(
                            1.5,
                            Center(
                                child: Text(
                              'OR',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                            )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FadeAnimation(
                              1.6,
                              Container(
                                margin: EdgeInsets.only(bottom: 30),
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 17, 0, 17),
                                  color: Colors.blueAccent,
                                  splashColor: Colors.blueAccent,
                                  onPressed:
                                      _isLoading ? null : () => _onTap(false),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: _isLoading
                                      ? CircularProgressIndicator()
                                      : Text(
                                          'Get Weather by Location',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                ),
                              )),
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
