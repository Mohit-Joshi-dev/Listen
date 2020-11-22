import 'package:Alarm/Const/const.dart';
import 'package:Alarm/Models/music.dart';
import 'package:Alarm/Providers/nowplaying_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllMusic extends StatefulWidget {
  @override
  _AllMusicState createState() => _AllMusicState();
}

class _AllMusicState extends State<AllMusic> {
  @override
  Widget build(BuildContext context) {
    var musics = Provider.of<List<Music>>(context);
    var provider = Provider.of<NowPlayingProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: kBackgroundColor,
        body: musics == null
            ? CircularProgressIndicator()
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1),
                itemCount: musics?.length,
                // 2,
                itemBuilder: (context, i) {
                  var music = musics[i];
                  print(music.url);
                  print(music.name);

                  return GestureDetector(
                    onTap: () {
                      provider.setMusic(music);
                      Navigator.pop(context);
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                BoxShadow(
                                    blurRadius: 25,
                                    color: Colors.black54,
                                    offset: Offset(3, 5))
                              ])),
                        ),
                        Positioned(
                            bottom: 18,
                            left: 18,
                            child: Text(
                              music.name,
                              // 'Name',
                              style: TextStyle(
                                  color: kBackgroundColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Mon',
                                  fontSize: 15),
                            ))
                      ],
                    ),
                  );
                })
        // StreamBuilder(
        //   builder: (context, snapshot) {
        //     final data = snapshot.data;
        //     if (!snapshot.hasData) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else {
        //       // print(snapshot.data);
        //       return GridView.builder(
        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //             crossAxisCount: 2,
        //             crossAxisSpacing: 20,
        //             mainAxisSpacing: 20,
        //             childAspectRatio: 1),
        //         itemBuilder: (context, i) {
        //           return GestureDetector(
        //             onTap: () {
        //               // Navigator.pop(context, [
        //               //   data.documents[i]['song_name'],
        //               //   data.documents[i]['song_url']
        //               // ]);

        //               playAudioByIndex(context, i, data);
        //             },
        //             child: Stack(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Container(
        //                       decoration: BoxDecoration(
        //                           color: kPrimaryColor,
        //                           borderRadius: BorderRadius.circular(24),
        //                           boxShadow: [
        //                         BoxShadow(
        //                             blurRadius: 25,
        //                             color: Colors.black54,
        //                             offset: Offset(3, 5))
        //                       ])),
        //                 ),
        //                 Positioned(
        //                     bottom: 18,
        //                     left: 18,
        //                     child: Text(
        //                       data.documents[i]['song_name'],
        //                       style: TextStyle(
        //                           color: kBackgroundColor,
        //                           fontWeight: FontWeight.w600,
        //                           fontFamily: 'Mon',
        //                           fontSize: 15),
        //                     ))
        //               ],
        //             ),
        //           );
        //         },
        //         itemCount: data.documents.length ?? 0,
        //       );
        //     }
        //   },
        //   stream: FirebaseFirestore.instance.collection('music').snapshots(),
        // ),
        );
  }
}

// playAudioByIndex(BuildContext context, int index, dynamic data) async {
//   final id = data.documents[index]['song_url'];
//   print(id);
//   try {
//     await AudioService.start(
//       backgroundTaskEntrypoint: entrypoint,
//       // () {
//       //   AudioServiceBackground.run(() => AudioPlayerTask());
//       // },
//       androidNotificationChannelName: 'Playback',
//       androidNotificationColor: 0xFF2196f3,
//       androidStopForegroundOnPause: true,
//       androidEnableQueue: true,
//     );
//     AudioPlayerTask().onPlayFromMediaId(id);
//   } catch (e) {
//     print(e);
//   }
// if (AudioService.running) {
//   // The service is already running, hence we begin playback.
//   AudioService.playFromMediaId(id);
// } else {
//   // Start background music playback.
//   if (await AudioService.start(
//     backgroundTaskEntrypoint: backgroundTaskEntryPoint,
//     androidNotificationChannelName: 'Playback',
//     androidNotificationColor: 0xFF2196f3,
//     androidStopForegroundOnPause: true,
//     androidEnableQueue: true,
//   )) {
//     // Process for setting up the queue

//     // 1.Convert music catalog to mediaitem data type.
//     // final queue = data.documents.map((catalog) {
//     //   return MediaItem(
//     //     id: data.documents['id'],
//     //     album: data.documents['song_name'],
//     //     title: data.documents['song_name'],
//     //     // artist: catalog.artist,
//     //     // duration: Duration(seconds: catalog.duration),
//     //     // genre: catalog.genre,
//     //     // artUri: catalog.image,
//     //     // extras: {'source': catalog.source},
//     //   );
//     // }).toList();

//     // 2.Now we add our queue to audio player task & update mediaItem.
//     // await AudioService.updateMediaItem(queue[index]);
//     // await AudioService.updateQueue(queue);

//     // 3.Let's now begin the playback.
//     AudioService.playFromMediaId(id);

//     // Optionally, play from given position.
//     // if (position != null) AudioService.seekTo(position);
//   }
// }
//   }
// }
