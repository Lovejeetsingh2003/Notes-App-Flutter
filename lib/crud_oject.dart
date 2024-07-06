class CrudObject {
  int? id;
  String? title;
  String? description;

  CrudObject({
    this.id,
    this.title,
    this.description,
  });

  factory CrudObject.fromJson(Map<String, dynamic> json) => CrudObject(
        id: json["id"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
      };
}
