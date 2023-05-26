class NamedFile {
  String? name;
  String? file;

  NamedFile({
    this.name,
    this.file,
  });

  NamedFile.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? '-';
    file = json["file"] ?? '-';
  }
}
