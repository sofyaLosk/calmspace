import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const CalmSpaceApp());
}

class CalmSpaceApp extends StatelessWidget {
  const CalmSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalmSpace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8FB9A8)),
        scaffoldBackgroundColor: const Color(0xFFF4F1EA),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> quotes = const [
    "Bugün kendin için küçük bir mola ver.",
    "Derin bir nefes al ve rahatla.",
    "Her şey yavaş yavaş düzelecek.",
    "Kendine karşı nazik ol.",
    "Dinlenmek de üretkenliğin bir parçasıdır.",
    "Şu an sadece nefesine odaklan.",
    "Zihnini sakinleştir ve anın tadını çıkar.",
  ];

  void openPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "CalmSpace",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3D5A50),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Huzur ve rahatlama alanın",
                style: TextStyle(fontSize: 17, color: Color(0xFF6A7B73)),
              ),

              const SizedBox(height: 28),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Günün Sözü",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3D5A50),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      quotes[DateTime.now().day % quotes.length],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6A7B73),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              HomeCard(
                title: "Rahatlatıcı Sesler",
                subtitle: "Doğa sesleri ve meditasyon",
                icon: Icons.music_note_rounded,
                onTap: () => openPage(context, const SoundsScreen()),
              ),

              const SizedBox(height: 18),

              HomeCard(
                title: "Nefes Teknikleri",
                subtitle: "Animasyonlu nefes egzersizleri",
                icon: Icons.self_improvement_rounded,
                onTap: () => openPage(context, const BreathingScreen()),
              ),

              const SizedBox(height: 18),

              HomeCard(
                title: "Hızlı Rahatlama",
                subtitle: "5, 10 ve 20 dakikalık zamanlayıcı",
                icon: Icons.timer_rounded,
                onTap: () => openPage(
                  context,
                  const TimerScreen(title: "Hızlı Rahatlama", minutes: 5),
                ),
              ),

              const Spacer(),

              const Center(
                child: Text(
                  "Dur. Nefes al. Rahatla.",
                  style: TextStyle(color: Color(0xFF7B8D85), fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const HomeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFFE2EFE8),
              child: Icon(icon, color: const Color(0xFF4E7D6A), size: 30),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3D5A50),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF7B8D85),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Color(0xFF8FA39A),
            ),
          ],
        ),
      ),
    );
  }
}

class SoundsScreen extends StatefulWidget {
  const SoundsScreen({super.key});

  @override
  State<SoundsScreen> createState() => _SoundsScreenState();
}

class _SoundsScreenState extends State<SoundsScreen> {
  final AudioPlayer player = AudioPlayer();
  String? currentSound;

  final List<SoundItem> sounds = [
    SoundItem("Yağmur", "Yumuşak yağmur sesi", "rain.mp3", Icons.water_drop),
    SoundItem("Orman", "Kuşlar ve doğa sesleri", "forest.mp3", Icons.park),
    SoundItem("Dalgalar", "Sakin deniz sesi", "waves.mp3", Icons.waves),
    SoundItem(
      "Beyaz Gürültü",
      "Dengeli arka plan sesi",
      "white_noise.mp3",
      Icons.graphic_eq,
    ),
    SoundItem(
      "Şömine",
      "Sıcak şömine sesi",
      "fireplace.mp3",
      Icons.local_fire_department,
    ),
    SoundItem("Rüzgar", "Hafif rüzgar sesi", "wind.mp3", Icons.air),
    SoundItem(
      "Gece Ormanı",
      "Gece doğa atmosferi",
      "night_forest.mp3",
      Icons.nightlight_round,
    ),
    SoundItem(
      "Meditasyon",
      "Tibet meditasyon sesi",
      "tibetan_meditation.mp3",
      Icons.self_improvement,
    ),
    SoundItem(
      "Şifa",
      "Rahatlatıcı healing sesi",
      "healing.mp3",
      Icons.favorite,
    ),
    SoundItem(
      "Bilinçaltı",
      "Sakin subconscious frekansı",
      "subconscious.mp3",
      Icons.psychology,
    ),
    SoundItem("Hüzün", "Duygusal rahatlama sesi", "sadness.mp3", Icons.cloud),
    SoundItem("Dinlenme", "Derin rahatlama müziği", "relax.mp3", Icons.spa),
    SoundItem("Kuşlar", "Doğal kuş sesleri", "birds.mp3", Icons.flutter_dash),
  ];

  Future<void> playSound(SoundItem sound) async {
    if (currentSound == sound.fileName) {
      await player.stop();
      setState(() {
        currentSound = null;
      });
    } else {
      await player.stop();
      await player.setReleaseMode(ReleaseMode.loop);
      await player.play(AssetSource("sounds/${sound.fileName}"));
      setState(() {
        currentSound = sound.fileName;
      });
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Rahatlatıcı Sesler",
      child: Column(
        children: [
          const Text(
            "Rahatlamana yardımcı olacak bir ses seç.",
            style: TextStyle(fontSize: 16, color: Color(0xFF6A7B73)),
          ),
          const SizedBox(height: 20),
          ...sounds.map(
            (sound) => SoundCard(
              sound: sound,
              isPlaying: currentSound == sound.fileName,
              onTap: () => playSound(sound),
            ),
          ),
        ],
      ),
    );
  }
}

class SoundItem {
  final String title;
  final String subtitle;
  final String fileName;
  final IconData icon;

  SoundItem(this.title, this.subtitle, this.fileName, this.icon);
}

class SoundCard extends StatelessWidget {
  final SoundItem sound;
  final bool isPlaying;
  final VoidCallback onTap;

  const SoundCard({
    super.key,
    required this.sound,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isPlaying ? const Color(0xFFDCEDE5) : Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              Icon(sound.icon, color: const Color(0xFF4E7D6A), size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sound.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3D5A50),
                      ),
                    ),
                    Text(
                      sound.subtitle,
                      style: const TextStyle(color: Color(0xFF7B8D85)),
                    ),
                  ],
                ),
              ),
              Icon(
                isPlaying ? Icons.stop_circle : Icons.play_circle,
                color: const Color(0xFF4E7D6A),
                size: 34,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BreathingScreen extends StatelessWidget {
  const BreathingScreen({super.key});

  final List<BreathingTechnique> techniques = const [
    BreathingTechnique(
      title: "4-4-4 Nefesi",
      description: "4 saniye nefes al, 4 saniye tut, 4 saniye nefes ver.",
      minutes: 3,
      icon: Icons.air_rounded,
    ),
    BreathingTechnique(
      title: "4-7-8 Nefesi",
      description: "4 saniye nefes al, 7 saniye tut, 8 saniye nefes ver.",
      minutes: 4,
      icon: Icons.spa_rounded,
    ),
    BreathingTechnique(
      title: "Sakin Nefes",
      description: "Yavaş nefes al ve uzun nefes ver. Dinlenmek için uygundur.",
      minutes: 5,
      icon: Icons.favorite_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Nefes Teknikleri",
      child: Column(
        children: [
          const Text(
            "Bir teknik seç ve nefesine odaklan.",
            style: TextStyle(fontSize: 16, color: Color(0xFF6A7B73)),
          ),
          const SizedBox(height: 20),
          ...techniques.map((technique) => BreathingCard(technique: technique)),
        ],
      ),
    );
  }
}

class BreathingTechnique {
  final String title;
  final String description;
  final int minutes;
  final IconData icon;

  const BreathingTechnique({
    required this.title,
    required this.description,
    required this.minutes,
    required this.icon,
  });
}

class BreathingCard extends StatelessWidget {
  final BreathingTechnique technique;

  const BreathingCard({super.key, required this.technique});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TimerScreen(
                title: technique.title,
                minutes: technique.minutes,
                description: technique.description,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: const Color(0xFFE2EFE8),
                child: Icon(technique.icon, color: const Color(0xFF4E7D6A)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      technique.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3D5A50),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      technique.description,
                      style: const TextStyle(color: Color(0xFF7B8D85)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerScreen extends StatefulWidget {
  final String title;
  final int minutes;
  final String? description;

  const TimerScreen({
    super.key,
    required this.title,
    required this.minutes,
    this.description,
  });

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late int selectedMinutes;
  late int secondsLeft;

  Timer? timer;
  Timer? animationTimer;

  bool isRunning = false;

  double circleSize = 230;
  String breathingText = "Nefes Al";

  final AudioPlayer finishPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    selectedMinutes = widget.minutes;
    secondsLeft = selectedMinutes * 60;
  }

  void startTimer() {
    if (isRunning) return;

    setState(() {
      isRunning = true;
    });

    animationTimer = Timer.periodic(const Duration(seconds: 4), (
      animationTimer,
    ) {
      if (!isRunning) {
        animationTimer.cancel();
        return;
      }

      setState(() {
        if (circleSize == 230) {
          circleSize = 280;
          breathingText = "Nefes Al";
        } else if (circleSize == 280) {
          circleSize = 250;
          breathingText = "Tut";
        } else {
          circleSize = 230;
          breathingText = "Nefes Ver";
        }
      });
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (secondsLeft > 0) {
        setState(() {
          secondsLeft--;
        });
      } else {
        stopTimer();

        await finishPlayer.play(AssetSource("sounds/healing.mp3"));

        if (mounted) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              title: const Text("Süre Tamamlandı"),
              content: const Text(
                "Harika iş çıkardın. Biraz rahatlamaya zaman ayırdın.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Tamam"),
                ),
              ],
            ),
          );
        }
      }
    });
  }

  void pauseTimer() {
    timer?.cancel();
    animationTimer?.cancel();

    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    timer?.cancel();
    animationTimer?.cancel();

    setState(() {
      secondsLeft = selectedMinutes * 60;
      isRunning = false;
      circleSize = 230;
      breathingText = "Nefes Al";
    });
  }

  void stopTimer() {
    timer?.cancel();
    animationTimer?.cancel();

    setState(() {
      isRunning = false;
    });
  }

  String get formattedTime {
    final minutes = secondsLeft ~/ 60;
    final seconds = secondsLeft % 60;

    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  Widget timerChip(int minutes) {
    return ChoiceChip(
      label: Text("$minutes dk"),
      selected: selectedMinutes == minutes,
      onSelected: (_) {
        setState(() {
          selectedMinutes = minutes;
          secondsLeft = minutes * 60;
        });
      },
      selectedColor: const Color(0xFFDCEDE5),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    animationTimer?.cancel();
    finishPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.title,
      child: Column(
        children: [
          if (widget.description != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(
                widget.description!,
                style: const TextStyle(fontSize: 16, color: Color(0xFF6A7B73)),
              ),
            ),

          const SizedBox(height: 30),

          Wrap(
            spacing: 10,
            children: [timerChip(5), timerChip(10), timerChip(20)],
          ),

          const SizedBox(height: 35),

          AnimatedContainer(
            duration: const Duration(seconds: 4),
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFDCEDE5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    breathingText,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E7D6A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    formattedTime,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3D5A50),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 35),

          MainButton(
            text: isRunning ? "Duraklat" : "Başlat",
            icon: isRunning ? Icons.pause : Icons.play_arrow,
            onTap: isRunning ? pauseTimer : startTimer,
          ),

          const SizedBox(height: 12),

          MainButton(
            text: "Sıfırla",
            icon: Icons.restart_alt,
            onTap: resetTimer,
          ),
        ],
      ),
    );
  }
}

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const AppScaffold({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: const Color(0xFF3D5A50),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 31,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3D5A50),
                ),
              ),
              const SizedBox(height: 22),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const MainButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(text, style: const TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8FB9A8),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
