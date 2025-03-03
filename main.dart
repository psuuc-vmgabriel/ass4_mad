import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Map<String, String>> _song = [
    {'title': 'Home - Daughtry', 'path': 'assets/audio/song1.mp3'},
    {'title': 'Far Away - Nikelback', 'path': 'assets/audio/song2.mp3'},
    {'title': 'Whereever You Will Go - The Calling ', 'path': 'assets/audio/song3.mp3'},
    {'title': 'Wonderwall - Aosis', 'path': 'assets/audio/song4.mp3'},
    {'title': 'Collide - Howie Day', 'path': 'assets/audio/song5.mp3'},
  ];
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _currentIndex;

  void _playSong(int index) async {
    if (_currentIndex == index) {
      _audioPlayer.stop();
      setState(() => _currentIndex = null);
    } else {
      await _audioPlayer.setAsset(_song[index]['path']!);
      _audioPlayer.play();
      setState(() => _currentIndex = index);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Favorite Songs')),
      body: ListView.builder(
        itemCount: _song.length,
        itemBuilder: (context, index){
          bool isPlaying = _currentIndex == index;
          return ListTile(
            leading: Icon(isPlaying? Icons.pause_circle: Icons.play_circle),
            title: Text(_song[index]['title']!),
            onTap: ()=> _playSong(index),
          );
        },
      ),
    );
  }
}
