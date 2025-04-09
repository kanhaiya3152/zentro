// src/presentation/audio/screens/audio_screen.dart
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
    _player.setAsset('assets/audio/sample.mp3');
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
        (position, duration) => DurationState(position, duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Player')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<DurationState>(
              stream: _durationState,
              builder: (context, snapshot) {
                final duration = snapshot.data?.total ?? Duration.zero;
                final position = snapshot.data?.position ?? Duration.zero;
                return Column(
                  children: [
                    Slider(
                      min: 0.0,
                      max: duration.inMilliseconds.toDouble(),
                      value: position.inMilliseconds.toDouble().clamp(0.0, duration.inMilliseconds.toDouble()),
                      onChanged: (value) => _player.seek(Duration(milliseconds: value.toInt())),
                    ),
                    Text(
                      "${position.toString().split('.').first} / ${duration.toString().split('.').first}"
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.play_arrow, size: 36),
                  onPressed: () => _player.play(),
                ),
                IconButton(
                  icon: const Icon(Icons.pause, size: 36),
                  onPressed: () => _player.pause(),
                )
              ],
            )
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
