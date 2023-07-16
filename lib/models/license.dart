class License {
  String? key;
  String? name;
  String? spdxId;
  String? url;
  String? nodeId;

  License({this.key, this.name, this.spdxId, this.url, this.nodeId});

  factory License.fromJson(Map<String, Object?> json) => License(
        key: json['key'] as String?,
        name: json['name'] as String?,
        spdxId: json['spdx_id'] as String?,
        url: json['url'] as String?,
        nodeId: json['node_id'] as String?,
      );

  Map<String, Object?> toJson() => {
        'key': key,
        'name': name,
        'spdx_id': spdxId,
        'url': url,
        'node_id': nodeId,
      };
}
