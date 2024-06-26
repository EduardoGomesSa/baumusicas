class PlaylistModel {
  int id;
  String name;

  PlaylistModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory PlaylistModel.fromMap(Map<String, dynamic> map) {
    return PlaylistModel(
      id: map['id'],
      name: map['name'],
    );
  }

  static List<PlaylistModel> fromList(list) {
    return List<PlaylistModel>.from(list.map((x) => PlaylistModel.fromMap(x)));
  }
}
