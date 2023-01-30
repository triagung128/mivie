import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: kRichBlack,
              child: Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 128,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32.0),
              color: kMikadoYellow,
              child: const Text(
                // 'Ditonton Yuk merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.',
                'Ditonton Yuk merupakan sebuah aplikasi katalog film dan tv series. Aplikasi ini dibuat sebagai submission pada kelas Menjadi Flutter Developer Expert by Dicoding Academy.',
                style: TextStyle(color: Colors.black87, fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
