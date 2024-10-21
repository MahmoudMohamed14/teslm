import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl; // URL or path of the audio file

  const AudioPlayerWidget({super.key, required this.audioUrl});

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  Duration _totalDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    _audioPlayer = AudioPlayer();

    // Setup the audio session for playback focus
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    // Load the audio file (local or network)
    await _audioPlayer.setUrl(widget.audioUrl);

    // Listen to changes in duration and position
    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _totalDuration = duration ?? Duration.zero;
      });
    });

    _audioPlayer.positionStream.listen((position) {
      setState(() {
        if (position == _totalDuration) {
          _isPlaying = false;
        } else {
          _currentPosition = position;
        }
      });
    });

    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Format time to mm:ss for display
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  // Toggle play/pause
  void _togglePlayback() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  // Seek audio
  void _seekAudio(Duration position) {
    _audioPlayer.seek(position);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          // Play/pause button
          IconButton(
            icon: Transform.flip(
              flipX: true,
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 30.0,
              ),
            ),
            onPressed: _togglePlayback,
          ),
          Text(_formatDuration(_isPlaying ? _currentPosition : _totalDuration)),
          Expanded(
            child: Slider(
              min: 0.0,
              max: _totalDuration.inMilliseconds.toDouble() + 1,
              value: _currentPosition.inMilliseconds.toDouble(),
              onChanged: (value) {
                _seekAudio(Duration(milliseconds: value.toInt()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
