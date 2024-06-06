import 'package:flutter/material.dart';
import 'login_page.dart';
import 'bbs_observasi_form.dart';
import 'indsiden_kerja_form.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF4F5FA), // Ganti warna AppBar menjadi biru
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 5, 155, 255),
            foregroundColor: Colors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.indigo[400],
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelStyle: const TextStyle(color: Colors.grey),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF4F5FA),
        appBar: AppBar(
          title: const Text('App-man HES'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Halo!',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const Text('Silahkan pilih salah satu menu dibawah untuk lanjut'),
              const SizedBox(height: 23),
              Menu(
                imageUrl: 'assets/png/observasi.png',
                printing: 'Navigating to BBS Observasi',
                titleCard: 'BBS Observasi',
                subtitleCard:
                    'Behavior Based Safety (BBS) adalah proses pendekatan untuk meningkatkan keselamatan kesehatan kerja dan lingkungan kerja',
                navigateTo: (context) => const ObservasiForm(),
              ),
              const SizedBox(height: 20),
              Menu(
                imageUrl: 'assets/png/insiden_kerja.png',
                printing: 'Navigating to Insiden Kerja',
                titleCard: 'Insiden Kerja',
                subtitleCard:
                    'Insiden kerja adalah kejadian tidak terduga yang dapat menyebabkan cedera atau kerusakan.',
                navigateTo: (context) => InsidenDetailPage(
                  title: 'Insiden Kerja',
                  subtitle:
                      'Insiden kerja adalah kejadian tidak terduga yang dapat menyebabkan cedera atau kerusakan.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  final String printing;
  final String imageUrl;
  final String titleCard;
  final String subtitleCard;
  final WidgetBuilder navigateTo;

  Menu({
    Key? key,
    required this.printing,
    required this.imageUrl,
    required this.titleCard,
    required this.subtitleCard,
    required this.navigateTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print(printing);
          Navigator.push(
            context,
            MaterialPageRoute(builder: navigateTo),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(21),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  // 'assets/png/observasi.png',
                  '$imageUrl',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(width: 20),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titleCard,
                        style: TextStyle(
                          color: Color(0xFF3E3E3E),
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 178,
                        child: Text(
                          subtitleCard,
                          style: TextStyle(
                            color: Color(0xFF3E3E3E),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
