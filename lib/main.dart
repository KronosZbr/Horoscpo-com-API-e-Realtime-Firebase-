import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBsIIghXa9Z4x9wH2SbuDTL8AMBHnTBvSo",
      appId: "1:106857354409:android:168e1b72c02303465b05b8",
      messagingSenderId: "106857354409",
      projectId: "proj02-f07f1",
      databaseURL: "https://proj02-f07f1-default-rtdb.firebaseio.com/",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horoscope App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.deepPurple,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      home: const HoroscopePage(),
    );
  }
}

class HoroscopePage extends StatefulWidget {
  const HoroscopePage({super.key});

  @override
  State<HoroscopePage> createState() => _HoroscopePageState();
}

class _HoroscopePageState extends State<HoroscopePage> {
  final List<String> signs = [
    'Aries',
    'Taurus',
    'Gemini',
    'Cancer',
    'Leo',
    'Virgo',
    'Libra',
    'Scorpio',
    'Sagittarius',
    'Capricorn',
    'Aquarius',
    'Pisces',
  ];

  String _selectedSign = 'Aries';
  String _horoscopeText = 'Selecione seu signo e descubra seu horóscopo!';

  Future<void> _fetchAndSaveHoroscope() async {
    final url = Uri.parse(
      'https://horoscope-app-api.vercel.app/api/v1/get-horoscope/daily?sign=$_selectedSign&day=TODAY',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final text =
            data['data']['horoscope_data'] ?? 'Horóscopo não encontrado.';

        setState(() {
          _horoscopeText = text;
        });

        final dbRef = FirebaseDatabase.instance.ref();
        await dbRef.child('horoscopes').push().set({
          'sign': _selectedSign,
          'horoscope': text,
          'timestamp': DateTime.now().toIso8601String(),
        });
      } else {
        setState(() {
          _horoscopeText =
              'Erro ao buscar horóscopo (Código: ${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        _horoscopeText = 'Erro ao buscar horóscopo: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Horoscope App'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: Colors.grey[900],
                  value: _selectedSign,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  isExpanded: true,
                  items:
                      signs.map((String sign) {
                        return DropdownMenuItem<String>(
                          value: sign,
                          child: Text(
                            sign,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                  onChanged: (String? newSign) {
                    if (newSign != null) {
                      setState(() {
                        _selectedSign = newSign;
                      });
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Botão estilizado
            ElevatedButton(
              onPressed: _fetchAndSaveHoroscope,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Buscar e Salvar Horóscopo',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),

            const SizedBox(height: 30),

            // Caixa de resultado estilizada
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _horoscopeText,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
