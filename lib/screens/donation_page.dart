import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationPage extends StatelessWidget {
  const DonationPage();

  @override
  Widget build(BuildContext context) {
    void _launchURL() async {
      const _url = 'https://www.paypal.com/donate?hosted_button_id=986PSAHLH6N4L';
      if (await canLaunch(_url)) {
        await launch(_url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Could not launch PayPal payment website.'),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Buy Me a Coffee')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 40),
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 0.4,
              child: Image.asset('assets/images/bitcoin_logo.png'),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text('Scan this QR code with your wallet application:'),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: Image.asset('assets/images/Bitcoin_QR.png'),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text('Or copy the BTC Wallet Address:'),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(
                      color: Colors.white70,
                      style: BorderStyle.solid,
                    )),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(8.0),
                      decoration: ShapeDecoration(
                        color: Colors.blueGrey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.zero,
                            topRight: Radius.zero,
                          ),
                        ),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(btcAddress),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Colors.white70, style: BorderStyle.solid)),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: btcAddress));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('BTC Address copied to Clipboard.'),
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Text('Donate vía Paypal (open the PayPal payment website):'),
            ),
            FractionallySizedBox(
              widthFactor: 0.4,
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 10.0,
                  padding: EdgeInsets.all(10),
                ),
                onPressed: _launchURL,
                child: Image.asset('assets/images/paypal_logo.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const String btcAddress = '15ZpNzqbYFx9P7wg4U438JMwZr2q3W6fkS';
