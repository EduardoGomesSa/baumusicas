import 'dart:io';

import 'package:path_provider/path_provider.dart';

class MusicRepository {
  Future<void> get() async {
    final pathDocuments = await getExternalStorageDirectory(); 
    final musicDirectory = Directory('${pathDocuments!.path}/Music');

    if(!await musicDirectory.exists()){
      print('Diretorio não existe');
      return;
    }

    final mp3Files = await musicDirectory.listSync(
      recursive: true
    );

    for(final file in mp3Files){
      final fileName = file.path.split('/').last;
      print(fileName);
    }

    print(pathDocuments);
    print(mp3Files.length);
    print(mp3Files.first);
  }
}