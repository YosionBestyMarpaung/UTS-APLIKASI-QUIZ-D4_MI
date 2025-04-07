import 'package:flutter/material.dart'; // Import package Flutter untuk UI

void main() {
  runApp(const QuizApp()); // Menjalankan aplikasi QuizApp
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key}); // Konstruktor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan label debug
      theme: ThemeData(
        primarySwatch: Colors.blue, // Warna tema utama
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Warna latar belakang tombol
            foregroundColor: Color.fromARGB(255, 88, 30, 233), // Warna teks tombol
          ),
        ),
      ),
      home: const StartScreen(), // Halaman awal
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key}); // Konstruktor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 192, 203), // Warna latar belakang
      body: Center(
        child: ElevatedButton(
          child: const Text("Mulai Quiz"), // Teks tombol
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QuizScreen()), // Navigasi ke halaman quiz
            );
          },
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key}); // Konstruktor

  @override
  _QuizScreenState createState() => _QuizScreenState(); // Membuat state
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0; // Indeks soal saat ini
  int _score = 0; // Skor pengguna
  String? _selectedAnswer; // Jawaban yang dipilih
  Color _backgroundColor = Colors.white; // Warna latar
  bool _isSubmitting = false; // Status submit

  // Daftar pertanyaan
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Apa kepanjangan dari UNESA?',
      'options': [
        'Universitas Negeri Semarang',
        'Universitas Negeri Surabaya',
        'Universitas Negeri Solo',
        'Universitas Negeri Sumatera'
      ],
      'answer': 'Universitas Negeri Surabaya'
    },
    {
      'question': 'Pada tahun berapa Program Studi D4 Manajemen Informatika UNESA didirikan?',
      'options': ['2012', '2015', '2019', '2021'],
      'answer': '2019'
    },
    {
      'question': 'Program Studi D4 Manajemen Informatika UNESA sebelumnya merupakan program studi apa?',
      'options': [
        'D3 Teknik Informatika',
        'D3 Sistem Informasi',
        'D3 Manajemen Informatika',
        'D3 Ilmu Komputer'
      ],
      'answer': 'D3 Manajemen Informatika'
    },
    {
      'question': 'Apa fokus utama dari kurikulum D4 Manajemen Informatika UNESA?',
      'options': [
        'Pengembangan perangkat keras',
        'Pengembangan aplikasi Desktop, Website, dan Mobile',
        'Jaringan komputer',
        'Keamanan siber'
      ],
      'answer': 'Pengembangan aplikasi Desktop, Website, dan Mobile'
    },
    {
      'question': 'Apa visi dari Program Studi D4 Manajemen Informatika UNESA?',
      'options': [
        'Menjadi program studi yang unggul dan kompetitif',
        'Menjadi pusat penelitian teknologi informasi',
        'Menghasilkan lulusan dengan IPK tinggi',
        'Menjadi program studi terbesar di Indonesia'
      ],
      'answer': 'Menjadi program studi yang unggul dan kompetitif'
    },
    {
      'question': 'Apa tujuan utama dari Program Studi D4 Manajemen Informatika UNESA?',
      'options': [
        'Menghasilkan lulusan dengan karakter tangguh, adaptif, dan inovatif',
        'Menghasilkan lulusan dengan kemampuan bahasa asing',
        'Menghasilkan lulusan dengan keterampilan manajerial',
        'Menghasilkan lulusan dengan kemampuan desain grafis'
      ],
      'answer': 'Menghasilkan lulusan dengan karakter tangguh, adaptif, dan inovatif'
    },
    {
      'question': 'Apa saja prospek pekerjaan bagi lulusan D4 Manajemen Informatika UNESA?',
      'options': [
        'Dokter dan Perawat',
        'Sistem Analis, Pengembang Perangkat Lunak, dan Konsultan IT',
        'Guru dan Dosen',
        'Pengacara dan Notaris'
      ],
      'answer': 'Sistem Analis, Pengembang Perangkat Lunak, dan Konsultan IT'
    },
    {
      'question': 'Apa keunikan dari Program Studi D4 Manajemen Informatika UNESA?',
      'options': [
        'Fokus pada pengembangan perangkat keras',
        'Mengintegrasikan kewirausahaan dalam bidang rekayasa perangkat lunak',
        'Menekankan pada ilmu sosial dan humaniora',
        'Berfokus pada ilmu ekonomi'
      ],
      'answer': 'Mengintegrasikan kewirausahaan dalam bidang rekayasa perangkat lunak'
    },
    {
      'question': 'Apa saja kemampuan teknis yang diajarkan di Program Studi D4 Manajemen Informatika UNESA?',
      'options': [
        'Pengembangan aplikasi Desktop, Website, dan Mobile',
        'Pengembangan perangkat keras',
        'Analisis data statistik',
        'Manajemen sumber daya manusia'
      ],
      'answer': 'Pengembangan aplikasi Desktop, Website, dan Mobile'
    },
    {
      'question': 'Apa saja soft skill yang dikembangkan dalam Program Studi D4 Manajemen Informatika UNESA?',
      'options': [
        'Kemampuan komunikasi dan kerja tim',
        'Kemampuan memasak',
        'Kemampuan olahraga',
        'Kemampuan seni musik'
      ],
      'answer': 'Kemampuan komunikasi dan kerja tim'
    }
  ];

  void _submitAnswer() {
    if (_isSubmitting) return; // Cegah klik ganda
    setState(() {
      _isSubmitting = true;
    });

    // Cek apakah jawaban benar
    bool isCorrect = _selectedAnswer == questions[_currentQuestionIndex]['answer'];

    setState(() {
      if (isCorrect) {
        _score += 10; // Tambah skor jika benar
        _backgroundColor = Colors.green; // Warna hijau jika benar
      } else {
        _backgroundColor = Colors.red; // Warna merah jika salah
      }
    });

    // Tunda 1 detik untuk ke soal berikutnya
    Future.delayed(const Duration(seconds: 1), () {
      if (_currentQuestionIndex < questions.length - 1) {
        setState(() {
          _currentQuestionIndex++; // Soal berikutnya
          _selectedAnswer = null; // Reset pilihan
          _backgroundColor = Colors.white; // Reset background
          _isSubmitting = false; // Reset status submit
        });
      } else {
        // Jika sudah soal terakhir, navigasi ke hasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(score: _score), // Kirim skor
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor, // Warna latar
      appBar: AppBar(title: const Text("Quiz")), // Judul appbar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Soal \${_currentQuestionIndex + 1} dari \${questions.length}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(
              questions[_currentQuestionIndex]['question'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...questions[_currentQuestionIndex]['options'].map<Widget>((option) {
              return RadioListTile(
                title: Text(option), // Teks opsi
                value: option,
                groupValue: _selectedAnswer, // Opsi yang dipilih
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value.toString(); // Simpan jawaban
                  });
                },
              );
            }).toList(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (_selectedAnswer != null && !_isSubmitting) ? _submitAnswer : null, // Aktif jika jawaban dipilih
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score; // Skor akhir
  const ResultScreen({super.key, required this.score}); // Konstruktor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hasil Quiz")), // Judul halaman hasil
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Skor Kamu: \$score", // Tampilkan skor
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Ulangi Quiz"),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst); // Kembali ke halaman awal
              },
            ),
          ],
        ),
      ),
    );
  }
}
