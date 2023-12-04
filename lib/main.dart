import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player 2023',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),//.dart(),
      
      home: AllSongs(),
    );
  }
}
class AllSongs extends StatefulWidget {
  const AllSongs({super.key});

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
  }

  void requestPermission(){
    Permission.storage.request();
  }
  final _audioQuery = new OnAudioQuery();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Music Player 2023"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search),),
        ],
      ),

    body: FutureBuilder<List<SongModel>>(
      future: _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true
      ),
      builder: (context, item) {
        if(item.data == null) {
          return const Center(
           child: CircularProgressIndicator(),
          );
        }
        if(item.data!.isEmpty){
          return Center(child: const Text("No Songs found"));
        }

        return ListView.builder(
          itemBuilder: (context, index) => ListTile(
            leading: const Icon(Icons.music_note),
            title: Text(item.data![index].displayNameWOExt),
            subtitle: Text("${item.data![index].artist}"),
            trailing: const Icon(Icons.more_horiz),
           ),
        itemCount: item.data!.length,
         );
        },
      ),
    );
  }
}

