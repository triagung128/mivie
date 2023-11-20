import 'package:flutter/material.dart';

import 'package:core/core.dart';

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
                  width: 210,
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
                'Ditonton Yuk is an application catalog of movies and tv series. This application was created as a submission final project the become a flutter developer expert by dicoding academy class.',
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
