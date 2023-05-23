class Song {
  final String title;
  final String singers;
  final String description;
  final String url;
  final String coverUrl;

  Song({
    required this.title,
    required this.singers,
    required this.description,
    required this.url,
    required this.coverUrl,
  });

  static List<Song> songs = [
    Song(
        title: 'After Dark',
        singers: 'Mr.Kitty',
        description: 'after dark',
        url: "assets/music/After_Dark.mp3",
        coverUrl: "assets/images/after_dark.jpeg"),
    Song(
        title: "Close Eyes",
        singers: "DVRST",
        description: "close eyes remix",
        url: "assets/music/Close_Eyes.mp3",
        coverUrl: "assets/images/close_eyes.jpeg"),
    Song(
        title: "Infinity",
        singers: "Jaymes Young",
        description: 'Infinity Song',
        url: "assets/music/Infinity.mp3",
        coverUrl: "assets/images/infinity.jpeg"),
  ];
}
