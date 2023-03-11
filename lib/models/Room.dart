class RoomTest {
  String title;
  List<String> imagePath;
  double rating;
  String price;
  String area;
  String address;
  String description;
  bool isFavorite;

  RoomTest(
      {required this.title,
      required this.imagePath,
      required this.rating,
      required this.price,
      required this.area,
      required this.address,
      required this.description,
      required this.isFavorite});
}

class RoomList {
  static List<RoomTest> rooms = [
    RoomTest(
        title: 'Trọ gác lửng',
        imagePath: [
          'assets/png/room1.png',
          'assets/png/room2.png',
          'assets/png/room3.png',
          'assets/png/room4.png',
          'assets/png/room5.png',
        ],
        area: '90',
        rating: 3.4,
        price: '5.000.000',
        address: '48 Hoa Sứ, Phường 7, Phú Nhuận',
        description:
            'Nhà cửa nhỏ nhắn và ấm cúng: Đây là một căn nhà nhỏ, tuy nhiên cực kỳ dễ thương và ấm áp. Nó có thể có những chi tiết trang trí tinh tế và màu sắc tươi sáng. Nó là nơi lý tưởng để thư giãn và tận hưởng những khoảnh khắc bình yên.',
        isFavorite: true),
    RoomTest(
        title: 'Ký túc xá',
        imagePath: [
          'assets/png/room1.png',
          'assets/png/room2.png',
          'assets/png/room3.png',
          'assets/png/room4.png',
          'assets/png/room5.png',
        ],
        area: '60',
        rating: 3.0,
        price: '500.000',
        description:
            'Ngôi nhà hiện đại: Mô tả cho một căn nhà hiện đại, sử dụng các vật liệu và thiết kế tối giản, trang trí đơn giản, tuy nhiên tạo cảm giác rộng rãi, thoải mái và sang trọng. Nó thường có nhiều cửa sổ, mang đến ánh sáng tự nhiên và tầm nhìn đẹp.',
        address: '480 Lê Văn Việt, Phường 7, Quận 9',
        isFavorite: false),
    RoomTest(
        title: 'Căn hộ 2 phòng ngủ',
        imagePath: ['assets/png/room4.png'],
        area: '80',
        rating: 4.5,
        price: '6.500.000',
        description:
            'Căn biệt thự rộng lớn: Đây là mô tả cho một căn nhà lớn, nhiều phòng, thường có sân vườn và bể bơi. Nó có thể có các phòng đa chức năng và tiện nghi như phòng tập thể dục, thư viện, rạp chiếu phim và phòng khách sang trọng. Đây là loại nhà lý tưởng cho các gia đình đông người hoặc những người yêu thích không gian rộng lớn.',
        address: 'Vinhome GrandPark 20 Nguyễn Xiển, P. Phước Long B, Quận 9',
        isFavorite: false),
    RoomTest(
        title: 'Căn hộ studio Sky9',
        imagePath: [
          'assets/png/room1.png',
          'assets/png/room2.png',
          'assets/png/room3.png',
          'assets/png/room4.png',
          'assets/png/room5.png',
        ],
        area: '80',
        rating: 5.0,
        price: '3.500.000',
        description:
            'Căn hộ tiện nghi: Mô tả cho một căn hộ hiện đại và tiện nghi với đầy đủ tiện ích, bao gồm cả khu vực giải trí và phòng gym. Nó thường được trang bị nội thất đẹp mắt và có tầm nhìn đẹp. Đây là lựa chọn lý tưởng cho những người yêu thích tiện nghi và sự tiện lợi.',
        address:
            'Đ. Liên Phường, Bình Trưng Đông, Quận 9, Thành phố Hồ Chí Minh',
        isFavorite: true),
    RoomTest(
        title: 'Nhà trọ có gác',
        imagePath: ['assets/png/room5.png'],
        area: '40',
        rating: 1.5,
        price: '1.500.000',
        description:
            'Ngôi nhà cổ điển: Mô tả cho một căn nhà theo phong cách cổ điển, thường có kiến trúc đẹp mắt và các chi tiết trang trí sang trọng. Nó có thể có cửa sổ to, cột trụ, hành lang dài và sân rộng. Nó là lựa chọn lý tưởng cho những người yêu thích phong cách kiến trúc truyền thống và lịch sử.',
        address:
            '462Đ.Liên Phường,Bình Trưng Đông, Quận 9, Thành phố Hồ Chí Minh',
        isFavorite: false),
  ];
}
