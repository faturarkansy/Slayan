import 'dart:async';
import 'package:flutter/material.dart';
import 'package:slayan/view/utility/home_page.dart'; // Pastikan path ini benar

// Model untuk konten OnBoarding
class OnBoard {
  final String logo, image, title, description;

  OnBoard({
    required this.logo,
    required this.image,
    required this.title,
    required this.description,
  });
}

// Daftar konten OnBoarding
final List<OnBoard> demoData = [
  OnBoard(
    logo: "assets/images/splash_logo_slayan_white.png",
    image: "assets/images/image1.png",
    title: "Temukan Peluang Karier",
    description:
        "Akses proyek freelance, magang, dan pameran karier virtual yang dirancang khusus untuk mahasiswa.",
  ),
  OnBoard(
    logo: "assets/images/splash_logo_slayan_white.png",
    image: "assets/images/image2.png",
    title: "Kembangkan Kreativitas",
    description:
        "Buat dan pamerkan portofolio digital untuk menunjukkan karya terbaik Anda kepada dunia.",
  ),
  OnBoard(
    logo: "assets/images/splash_logo_slayan_white.png",
    image: "assets/images/image3.png",
    title: "Terhubung dengan Perusahaan",
    description:
        "Jalin koneksi dengan perusahaan terkemuka melalui sesi jaringan dan wawancara langsung.",
  ),
];

// Definisikan kPrimaryColor jika tidak didefinisikan di tempat lain
const Color kPrimaryColor = Color(0xff6a1b9a); // Contoh warna

// OnBoardingScreen
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // Variabel
  late PageController _pageController;
  int _pageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Inisialisasi page controller
    _pageController = PageController(initialPage: 0);
    // Perilaku scroll otomatis
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageIndex < demoData.length - 1) {
        _pageIndex++;
      } else {
        _pageIndex = 0;
      }

      _pageController.animateToPage(
        _pageIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    // Buang semua yang perlu dibuang
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Area Carousel
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemCount: demoData.length,
                controller: _pageController,
                itemBuilder: (context, index) => OnBoardContent(
                  logo: demoData[index].logo,
                  title: demoData[index].title,
                  description: demoData[index].description,
                  image: demoData[index].image,
                  index: index, // Kirim index ke OnBoardContent
                ),
              ),
            ),
            // Area indikator
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    demoData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: DotIndicator(
                        isActive: index == _pageIndex,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 16,
            ),
            // Area tombol
            InkWell(
              onTap: () {
                // Navigasi ke halaman utama
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomePage(), // Ganti HomePage dengan widget halaman utama Anda
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 40),
                height: 50,
                width: 268,
                decoration: BoxDecoration(
                  color: Color(0xFF004D93),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Center(
                  child: Text(
                    "Mulai Sekarang!",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
                      fontSize: 18,
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

// Widget untuk area OnBoarding
class OnBoardContent extends StatelessWidget {
  const OnBoardContent({
    super.key,
    required this.logo,
    required this.image,
    required this.title,
    required this.description,
    required this.index,
  });

  final String logo;
  final String image;
  final String title;
  final String description;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Bentuk background berbentuk lingkaran untuk semua slide
        Positioned(
          top: index == 2
              ? -885
              : (index == 1 ? -1673 : (index == 0 ? -885 : 50)),
          left: index == 2
              ? -750
              : (index == 1 ? -840 : (index == 0 ? -130 : 50)),
          child: Container(
            height: index == 1 ? 2100 : 1300,
            width: index == 1 ? 2100 : 1300,
            decoration: BoxDecoration(
              color: Color(0xFF3D9FB5),
              shape: BoxShape
                  .circle, // Menggunakan BoxShape.circle untuk semua slide
            ),
          ),
        ),
        // Logo di bagian atas kiri
        Positioned(
          top: 25, // Jarak dari atas
          left: 35, // Jarak dari kiri
          child: Image.asset(
            logo,
            height: 90, // Sesuaikan dengan ukuran logo Anda
            width: 90, // Sesuaikan dengan ukuran logo Anda
          ),
        ),
        // Konten OnBoarding di atas bentuk background
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 350, // Mengurangi ukuran gambar dari 250 menjadi 200
                width: 350,
              ), // Gambar berada di tengah
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 62),
                child: Column(
                  children: [
                    const SizedBox(height: 28),
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'RedHatDisplay-Bold',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'RedHatDisplay-Medium',
                        color: Color(0xFF939394),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Widget indikator titik
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF004D93) : Color(0xFF979797),
        border: isActive ? null : Border.all(color: Color(0xFF979797)),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
