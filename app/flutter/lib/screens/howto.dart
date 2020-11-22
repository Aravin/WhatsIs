import 'package:flutter/material.dart';
import 'package:whats_is/widgets/app_drawer.dart';
import 'package:velocity_x/velocity_x.dart';

class HowToScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to Use'),
      ),
      drawer: CustomAppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    'How to use WhatsIs?'.text.gray900.bold.xl.make(),
                    HeightBox(10),
                    'Step 1'.text.bold.make(),
                    'Choose the country Code'.text.make(),
                    'Step 2'.text.bold.make(),
                    'Enter the Phone Number'.text.make(),
                    'Step 3'.text.bold.make(),
                    'Write your Message'.text.make(),
                    'Step 4'.text.bold.make(),
                    'Click on Send button'.text.make(),
                    HeightBox(20),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    'How does it work?'.text.gray900.bold.xl.make(),
                    HeightBox(10),
                    'WhatsApp\'s click to chat feature allows you to begin a chat with someone without having their phone number saved in your phone\'s address book. As long as you know this person’s phone number and they have an active WhatsApp account, you can create a link that will allow you to start a chat with them. By clicking the link, a chat with the person automatically opens. Click to chat works on both your phone and WhatsApp Web.'
                        .text
                        .make()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
