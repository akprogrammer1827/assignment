class SavedList {
  SavedList({
    this.name,
  });

  String? name;

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
