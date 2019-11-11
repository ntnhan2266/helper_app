import 'package:smart_rabbit/models/user_maid.dart';

List services = [
  {
    "name": "Giặt ủi",
    "price": r"$100",
    "location": "Quận 5, TP. HCM",
  },
  {
    "name": "Giặt ủi",
    "price": r"$100",
    "location": "Quận 5, TP. HCM",
  },
  {
    "name": "Giặt ủi",
    "price": r"$100",
    "location": "Quận 5, TP. HCM",
  },
  {
    "name": "Giặt ủi",
    "price": r"$100",
    "location": "Quận 5, TP. HCM",
  },
  {
    "name": "Giặt ủi",
    "price": r"$100",
    "location": "Quận 5, TP. HCM",
  },
  {
    "name": "Giặt ủi",
    "price": r"$100",
    "location": "Quận 5, TP. HCM",
  },
  {
    "name": "Giặt ủi",
    "price": r"$100",
    "location": "Quận 5, TP. HCM",
  },
];

List users = [
  {
    "name": "Binh An",
    "ratting": 5.0,
    "img": "assets/images/female_user.jpg",
  },
  {
    "name": "Binh An",
    "ratting": 5.0,
    "img": "assets/images/female_user.jpg",
  },
  {
    "name": "Binh An",
    "ratting": 4.5,
    "img": "assets/images/female_user.jpg",
  },
  {
    "name": "Binh An",
    "ratting": 4.5,
    "img": "assets/images/female_user.jpg",
  },
  {
    "name": "Binh An",
    "ratting": 4.0,
    "img": "assets/images/female_user.jpg",
  }
];

List reviews = [
  {
    'user': {'name': 'ngan123'},
    'username': 'ngan123',
    'ratting': 4.0,
    'content': 'Chăm chỉ \nLàm việc cũng cẩn thận',
    'createdAt': DateTime.now().toString(),
    'updatedAt': DateTime.now().toString(),
    'deletedAt': DateTime.now().toString(),
  },
  {
    'user': {'name': 'anhanhanh'},
    'username': 'anhanhanh',
    'ratting': 5.0,
    'content': 'Làm tốt công việc',
    'createdAt': DateTime.now().toString(),
    'updatedAt': DateTime.now().toString(),
    'deletedAt': DateTime.now().toString(),
  },
  {
    'user': {'name': 'binh56'},
    'username': 'binh56',
    'ratting': 4.5,
    'content': 'Tốt',
    'createdAt': DateTime.now().toString(),
    'updatedAt': DateTime.now().toString(),
    'deletedAt': DateTime.now().toString(),
  },
  {
    'user': {'name': 'trung874'},
    'username': 'trung874',
    'ratting': 4.0,
    'content': 'Cẩn thận và chu đáo',
    'createdAt': DateTime.now().toString(),
    'updatedAt': DateTime.now().toString(),
    'deletedAt': DateTime.now().toString(),
  },
];

var userMaids = [
  UserMaid(
    intro: 'intro',
    id: '1',
    literacyType: 1,
    exp: 'exp',
    salary: 1,
    jobTypes: [],
    supportAreas: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
    name: 'An Binh',
    email: 'anbinh123@gmail.com',
    gender: 1,
    birthday: DateTime(1997, 1, 1),
    phoneNumber: '0123456789',
    address: 'address',
    createdAt: DateTime.now(),
    avatar: 'avatar',
  ),
  UserMaid(
    intro: 'intro',
    id: '2',
    literacyType: 1,
    exp: 'exp',
    salary: 1,
    jobTypes: [],
    supportAreas: [],
    name: 'Hong Ngoc',
    email: 'email',
    gender: 1,
    birthday: DateTime(1997, 1, 1),
    phoneNumber: '0123456789',
    address: 'address',
    createdAt: DateTime.now(),
    avatar: 'avatar',
  ),
];
