class ProductProperty {
  // final String id;
  final String property; // Replace this with the actual field name for property name
  // Add any other properties you need

  ProductProperty({
    // required this.id,
    required this.property,
    // Add any other properties you need
  });

  factory ProductProperty.fromJson(Map<String, dynamic> json) {
    return ProductProperty(
      // id: json['id'].toString(),
      property: json['name'],
      // Add other properties as needed
    );
  }
}
