class Posts {
  DateTime date = DateTime.parse('2022-01-01');
  late String imageUrl;
  late int quantity;
  late double latitude;
  late double longitude;

  Posts({
    date, 
    this.imageUrl = '', 
    this.quantity = 0, 
    this.latitude = 0.0, 
    this.longitude = 0.0
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'date': date,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    };
  }

  Posts.firebase(post) {
    imageUrl = post['imageUrl'];
    date = post['date'].toDate();
    quantity = post['quantity'];
    latitude = post['latitude'];
    longitude = post['longitude'];
  }
}