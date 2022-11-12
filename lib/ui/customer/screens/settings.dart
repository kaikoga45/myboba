import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myboba/services/firebase_authentication/authentication.dart';
import 'package:myboba/ui/customer/components/rounded_text_box.dart';

class Settings extends StatelessWidget {
  static const String id = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SETTINGS',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  color: Color(0xFFFAFAFA),
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.heart,
                              size: 70,
                            ),
                            Icon(
                              Icons.add,
                              size: 70,
                              color: Color(0xFF026242),
                            ),
                            Container(
                              child: ClipRRect(
                                child: Image.asset(
                                  'assets/img/lentera.png',
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(140),
                              ),
                              height: 70,
                              width: 70,
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Made with full passion by the Lentera Teams which consists of 3 members namely Kai Koga, I Putu Arsana Putra, and Gusti Ayu Putu Setiari.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(height: 30),
                      RoundedTextBox(title: 'Credit'),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: ClipRRect(
                                    child: FadeInImage.assetNetwork(
                                      fit: BoxFit.cover,
                                      height: 50,
                                      width: 50,
                                      fadeInCurve: Curves.bounceIn,
                                      placeholder:
                                          'assets/img/fade_placeholder.png',
                                      image:
                                          'https://cdn.dribbble.com/users/4148292/screenshots/12115490/media/833cacbe9265766c49d69df14787418d.jpg',
                                    ),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(width: 10),
                                Text('Heinrich Albert at Dribble'),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  child: ClipRRect(
                                    child: FadeInImage.assetNetwork(
                                      fit: BoxFit.cover,
                                      height: 50,
                                      width: 50,
                                      fadeInCurve: Curves.bounceIn,
                                      placeholder:
                                          'assets/img/fade_placeholder.png',
                                      image:
                                          'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/d322aa89910451.5e05c71971e67.jpg',
                                    ),
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(width: 10),
                                Text('Katya Klimova at Behance'),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    AuthHelper.auth.signOut();
                  },
                  child: Text(
                    'LOGOUT',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
