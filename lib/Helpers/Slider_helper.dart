

class Slider_helper{
  String id;
  String category;
  String image;

  Slider_helper.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    category = data['category'];
    image = data['image'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'image': image,
    };
  }


}