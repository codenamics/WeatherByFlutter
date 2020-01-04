import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:weather/common/colors.dart';
import 'package:weather/providers/CurrentWeather.dart';
import 'package:weather/providers/ForcastWeatherProvider.dart';
import 'package:weather/screens/Weather.dart';
import 'package:weather/service/LocationService.dart';
import 'package:weather/utils/Fade.dart';
import 'package:weather/utils/Ripple.dart';

class LocationCity extends StatefulWidget {
  @override
  _LocationCityState createState() => _LocationCityState();
}

class _LocationCityState extends State<LocationCity> {
  bool isLoading = false;
  String text;
  Ripple ripple = Ripple();
  final Duration animationDuration = Duration(milliseconds: 500);
  final _form = GlobalKey<FormState>();
  final Duration delay = Duration(milliseconds: 0);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  GlobalKey rectGetterKeyLocation = RectGetter.createGlobalKey();
  Rect rect;

  void rippleRec(recKey) {
    setState(() => rect = RectGetter.getRectFromKey(recKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  }

  void dispose() {
    super.dispose();
  }

  Future _onTap(cityName) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (cityName) {
      final isValid = _form.currentState.validate();

      if (!isValid) {
        return;
      }
      setState(() {
        isLoading = true;
      });
      _form.currentState.save();

      await Provider.of<CurrentWeatherProvider>(context, listen: false)
          .getData(text);
      await Provider.of<ForcastWeatherProvider>(context, listen: false)
          .getForcast(text);
      setState(() {
        isLoading = false;
      });
      rippleRec(rectGetterKey);
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        await Location.getCurrentLocation();
        await Provider.of<CurrentWeatherProvider>(context, listen: false)
            .getDataLocation();
        await Provider.of<ForcastWeatherProvider>(context, listen: false)
            .getForcastLocation();
        setState(() {
          isLoading = false;
        });
        rippleRec(rectGetterKeyLocation);
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
                    isLoading = false;
                  });
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }
    _form.currentState.reset();
    setState(() {
      isLoading = false;
    });
  }

  void _goToNextPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(page: Weather()))
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
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        )),
                    Form(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              )),
                          hintText: 'CityName',
                          prefixText: ' ',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    RectGetter(
                      key: rectGetterKey,
                      child: FlatButton(
                        padding: EdgeInsets.fromLTRB(0, 17, 0, 17),
                        color: buttonColor,
                        splashColor: Colors.blueAccent,
                        onPressed: isLoading ? null : () => _onTap(true),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        child: isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                'Get Weather by CityName',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                      'OR',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    RectGetter(
                      key: rectGetterKeyLocation,
                      child: FlatButton(
                        
                        padding: EdgeInsets.fromLTRB(0, 17, 0, 17),
                        color: buttonColor,
                        splashColor: Colors.blueAccent,
                        onPressed: isLoading ? null : () => _onTap(false),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                'Get Weather by Location',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
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
