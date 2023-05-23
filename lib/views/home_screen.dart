import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../models/song_models.dart';
import '../widgets/song_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Song> songs = Song.songs;
    final List<String> categories = [
      "Trending Right Now",
      "Rock",
      "Hip Hop",
      "Electro",
      "Romantic"
    ];
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const _CustomAppBar(),
        bottomNavigationBar: const _CustomNavBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 20),
              Text(
                "Trending right now",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      return SongCard(song: songs[index]);
                    }),
              ),
              const SizedBox(
                height: 30,
              ),
              TrendingCategories(categories: categories),
              const SizedBox(
                height: 30,
              ),
              SongsList(songs: songs)
            ]),
          ),
        ),
      ),
    );
  }
}

class SongsList extends StatefulWidget {
  const SongsList({
    super.key,
    required this.songs,
  });

  final List<Song> songs;

  @override
  State<SongsList> createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = AudioPlayer();
    Song song = Song.songs[0];
    bool isPlaying = false;

    @override
    void initState() {
      super.initState();
      audioPlayer.setAudioSource(ConcatenatingAudioSource(
          children: [AudioSource.uri(Uri.parse('asset:///${song.url}'))]));
    }

    @override
    void dispose() {
      audioPlayer.dispose();
      super.dispose();
    }

    void playAudio() async {
      await audioPlayer.play();
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.30,
      child: ListView.builder(
        itemCount: widget.songs.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            height: 80,
            margin: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.deepPurple.withOpacity(0.9)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 70,
                          width: 70,
                          alignment: Alignment.center,
                          child: Image.asset(widget.songs[index].coverUrl)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 20),
                      child: SizedBox(
                        width: 100,
                        child: Column(
                          children: [
                            Text(
                              widget.songs[index].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.songs[index].singers,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40, bottom: 20),
                  child: IconButton(
                    icon: const Icon(
                      Icons.play_circle,
                      color: Colors.white,
                      size: 50,
                    ),
                    onPressed: () => playAudio(),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class TrendingCategories extends StatelessWidget {
  const TrendingCategories({
    super.key,
    required this.categories,
  });

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: ListView.builder(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 20),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    categories[index],
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class _CustomNavBar extends StatelessWidget {
  const _CustomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 6, right: 6),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey.withOpacity(0.5),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline), label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(Icons.play_circle_outlined), label: 'Play'),
            BottomNavigationBarItem(
                icon: Icon(Icons.people_outline), label: 'Profile'),
          ]),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 120,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.only(left: 10, top: 60),
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          child: const Icon(Icons.grid_view_rounded)),
      title: Container(
        margin: const EdgeInsets.only(left: 10, top: 60),
        padding: const EdgeInsets.only(top: 10, bottom: 0),
        decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.transparent)),
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            border: InputBorder.none,
            fillColor: Colors.transparent,
            focusColor: Colors.white,
            hintText: "Search",
            hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey.shade400),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade400,
              size: MediaQuery.of(context).size.width * 0.1,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120.0);
}
