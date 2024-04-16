class PlaylistModel {
  int id;
  String name;

  PlaylistModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
    };
  }
}
