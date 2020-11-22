import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whats_is/widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  _launchWhatsApp(String phoneNumber, String message) async {
    var url = 'https://wa.me/$phoneNumber?text=$message';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Message'),
      ),
      drawer: CustomAppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Compose Message".text.gray600.lg.make(),
                    SizedBox(height: 25),
                    FormBuilder(
                      key: _fbKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FormBuilderPhoneField(
                            autofocus: true,
                            attribute: "phone",
                            defaultSelectedCountryIsoCode: 'IN',
                            priorityListByIsoCode: ['IN', 'US', 'GB'],
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              labelText: "Phone Number",
                            ),
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                          ),
                          FormBuilderTextField(
                            attribute: "message",
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.message),
                              labelText: "Message",
                            ),
                            validators: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(
                                2,
                                allowEmpty: false,
                                errorText:
                                    'Message should be minimum 2 character',
                              ),
                              FormBuilderValidators.maxLength(
                                500,
                                errorText:
                                    'Message should be maximum 500 character',
                              ),
                            ],
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            minLines: 5,
                            maxLines: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton.icon(
                  color: Colors.red,
                  icon: Icon(
                    Icons.restore_sharp,
                    color: Colors.white,
                  ),
                  label: 'Reset'.text.white.make(),
                  onPressed: () {
                    _fbKey.currentState.reset();
                  },
                ),
                RaisedButton.icon(
                  color: Colors.green,
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  label: 'Send Message via WhatsApp'.text.white.make(),
                  onPressed: () {
                    if (_fbKey.currentState.saveAndValidate()) {
                      print(_fbKey.currentState.value);
                      _launchWhatsApp(_fbKey.currentState.value['phone'],
                          _fbKey.currentState.value['message']);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
