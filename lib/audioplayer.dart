import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.setAsset('assets/audio.mp3');
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Stream<DurationState> get _durationState =>
      Rx.combineLatest2<Duration, Duration, DurationState>(
        _player.positionStream,
        _player.durationStream.map((duration) => duration ?? Duration.zero),
        (position, duration) => DurationState(position, duration),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Audio Player',
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Album Art
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/album.jpg'), 
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Song Title
            const Text(
              "Sample Song",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            // Artist Name
            const Text(
              "Artist Name",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            // Slider and Duration
            StreamBuilder<DurationState>(
              stream: _durationState,
              builder: (context, snapshot) {
                final duration = snapshot.data?.total ?? Duration.zero;
                final position = snapshot.data?.position ?? Duration.zero;
                return Column(
                  children: [
                    Slider(
                      activeColor: Colors.deepPurple,
                      inactiveColor: Colors.grey[300],
                      min: 0.0,
                      max: duration.inMilliseconds.toDouble(),
                      value: position.inMilliseconds.toDouble().clamp(0.0, duration.inMilliseconds.toDouble()),
                      onChanged: (value) => _player.seek(Duration(milliseconds: value.toInt())),
                    ),
                    Text(
                      "${position.toString().split('.').first} / ${duration.toString().split('.').first}",
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
            // Play and Pause Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _player.play(),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Icon(Icons.play_arrow, size: 36, color: Colors.white),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _player.pause(),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Icon(Icons.pause, size: 36, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DurationState {
  final Duration position;
  final Duration total;

  DurationState(this.position, this.total);
}