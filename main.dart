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
    {
      'title': 'Wherever You Will Go - The Calling ',
      'path': 'assets/audio/song3.mp3',
    },
    {'title': 'Wonderwall - Aosis', 'path': 'assets/audio/song4.mp3'},
    {'title': 'Collide - Howie Day', 'path': 'assets/audio/song5.mp3'},
  ];
  void _openMusicPlayer(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => MusicPlayerScreen(songTitle: _song[index]['title']!,
            songPath: _song[index]['path']!,),
      ),
    );
  }

  // final AudioPlayer _audioPlayer = AudioPlayer();
  // int? _currentIndex;

  // void _playSong(int index) async {
  //   if (_currentIndex == index) {
  //     _audioPlayer.stop();
  //     setState(() => _currentIndex = null);
  //   } else {
  //     await _audioPlayer.setAsset(_song[index]['path']!);
  //     _audioPlayer.play();
  //     setState(() => _currentIndex = index);
  //   }
  // }

  @override
  // void dispose() {
  //   _audioPlayer.dispose();
  //   super.dispose();
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Favorite Songs')),
      body: ListView.builder(
        itemCount: _song.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.music_note, color: Colors.pink),
            trailing: Icon(Icons.play_arrow, color: Colors.red),
            title: Text(_song[index]['title']!),
            onTap: () => _openMusicPlayer(context, index),
          );
        },
      ),
    );
  }
}

class MusicPlayerScreen extends StatefulWidget {
  final String songTitle;
  final String songPath;

  const MusicPlayerScreen({
    super.key,
    required this.songTitle,
    required this.songPath,
  });

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _loadSong();
  }

  Future<void> _loadSong() async {
    await _audioPlayer.setAsset(widget.songPath);
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.songTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isPlaying ? Icons.music_note : Icons.music_off,
              size: 100,
              color: Colors.pinkAccent,
            ),
            SizedBox(height: 20),
            Text(
              widget.songTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
          ElevatedButton.icon(onPressed: _togglePlayPause, icon: Icon(_isPlaying? Icons.pause : Icons.play_arrow), label: Text(_isPlaying? 'Pause': 'Paly'),
          style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15)),)
          ],
        ),
      ),
    );
  }
}
