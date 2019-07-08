class JSONSettings {
  String version;
  String language;

  JSONSettings({this.version, this.language});

  JSONSettings.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['language'] = this.language;
    return data;
  }
}