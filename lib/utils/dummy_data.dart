import 'package:smart_rabbit/models/service_details.dart';
import 'package:smart_rabbit/models/user_maid.dart';

import '../models/service_category.dart';

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

var categoriesData = [
  ServiceCategory(
    id: 1,
    serviceName: 'house_cleaning',
    imgURL: 'assets/images/house_cleaning.png',
  ),
  ServiceCategory(
    id: 2,
    serviceName: 'garden',
    imgURL: 'assets/images/garden.png',
  ),
  ServiceCategory(
    id: 3,
    serviceName: 'go_to_market',
    imgURL: 'assets/images/go_to_market.png',
  ),
  ServiceCategory(
    id: 4,
    serviceName: 'child_care',
    imgURL: 'assets/images/child_care.png',
  ),
  ServiceCategory(
    id: 5,
    serviceName: 'laundry',
    imgURL: 'assets/images/laundry.png',
  ),
  ServiceCategory(
    id: 6,
    serviceName: 'other',
    imgURL: 'assets/images/other.png',
  ),
];

List reviews = [
  {
    'username': 'ngan123',
    'ratting': 4.0,
    'content': 'Chăm chỉ \nLàm việc cũng cẩn thận'
  },
  {'username': 'anhanhanh', 'ratting': 5.0, 'content': 'Làm tốt công việc'},
  {'username': 'binh56', 'ratting': 4.5, 'content': 'Tốt'},
  {'username': 'trung874', 'ratting': 4.0, 'content': 'Cẩn thận và chu đáo'},
];

var userMaids = [
  UserMaid(
    intro: 'intro',
    id: '1',
    literacyType: 1,
    exp: 'exp',
    salary: 1,
    jobTypes: [1,2,4],
    supportAreas: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
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

var serviceHistoty = [
  ServiceDetails(
    category: 1,
    status: 3,
    address: '123 Thành Thái, Q. 10',
    startTime: DateTime(2019, 9, 29, 8, 0, 0),
    endTime: DateTime(2019, 9, 29, 17, 0, 0),
    startDate: DateTime(2019, 9, 29),
    endDate: DateTime(2019, 9, 29),
    type: 1,
    maid: userMaids[0],
    amount: 500000,
  ),
  ServiceDetails(
    category: 0,
    status: 3,
    address: '20 Sư Vạn Hạnh, Q. 5',
    startTime: DateTime(2019, 9, 29, 8, 0, 0),
    endTime: DateTime(2019, 9, 29, 16, 30, 0),
    startDate: DateTime(2019, 9, 25),
    endDate: DateTime(2019, 10, 12),
    type: 2,
    maid: userMaids[1],
    amount: 1500000,
  ),
  ServiceDetails(
    category: 0,
    status: 3,
    address: '785 Lý Thường Kiệt, Q. 11',
    startTime: DateTime(2019, 9, 29, 9, 0, 0),
    endTime: DateTime(2019, 9, 29, 15, 0, 0),
    startDate: DateTime(2019, 9, 29),
    endDate: DateTime(2019, 9, 29),
    type: 1,
    maid: userMaids[0],
    amount: 1200000,
  ),
  ServiceDetails(
    category: 4,
    status: 3,
    address: '35 Nguyễn Trãi, Q. 10',
    startTime: DateTime(2019, 9, 29, 8, 30, 0),
    endTime: DateTime(2019, 9, 29, 15, 0, 0),
    startDate: DateTime(2019, 9, 10),
    endDate: DateTime(2019, 9, 29),
    type: 2,
    maid: userMaids[0],
    amount: 1300000,
  ),
  ServiceDetails(
    category: 3,
    status: 3,
    address: '10 Nguyễn Tri Phương, Q. 10',
    startTime: DateTime(2019, 9, 29, 8, 0, 0),
    endTime: DateTime(2019, 9, 29, 17, 0, 0),
    startDate: DateTime(2019, 9, 29),
    endDate: DateTime(2019, 9, 29),
    type: 1,
    maid: userMaids[1],
    amount: 5000000,
  ),
  ServiceDetails(
    category: 1,
    status: 3,
    address: '91 Ba Tháng Hai, Q. 10',
    startTime: DateTime(2019, 9, 29, 8, 0, 0),
    endTime: DateTime(2019, 9, 29, 17, 0, 0),
    startDate: DateTime(2019, 9, 29),
    endDate: DateTime(2019, 9, 29),
    type: 1,
    maid: userMaids[1],
    amount: 300000,
  ),
  ServiceDetails(
    category: 2,
    status: 3,
    address: '500 An Dương Vương, Q. 5',
    startTime: DateTime(2019, 9, 29, 8, 0, 0),
    endTime: DateTime(2019, 9, 29, 17, 0, 0),
    startDate: DateTime(2019, 9, 29),
    endDate: DateTime(2019, 9, 29),
    type: 1,
    maid: userMaids[0],
    amount: 12500000,
  ),
  ServiceDetails(
    category: 4,
    status: 3,
    address: '463 Tô Hiến Thành',
    startTime: DateTime(2019, 9, 29, 8, 0, 0),
    endTime: DateTime(2019, 9, 29, 17, 0, 0),
    startDate: DateTime(2019, 9, 29),
    endDate: DateTime(2019, 9, 29),
    type: 1,
    maid: userMaids[1],
    amount: 7500000,
  ),
  ServiceDetails(
    category: 0,
    status: 3,
    address: '26 Lê Lợi, Q. 1',
    startTime: DateTime(2019, 9, 29, 8, 0, 0),
    endTime: DateTime(2019, 9, 29, 17, 0, 0),
    startDate: DateTime(2019, 9, 29),
    endDate: DateTime(2019, 9, 29),
    type: 1,
    maid: userMaids[0],
    amount: 1400000,
  ),
  ServiceDetails(
    category: 3,
    status: 3,
    address: '5 Điện Biên Phủ, Q. 3',
    startTime: DateTime(2019, 9, 29, 8, 0, 0),
    endTime: DateTime(2019, 9, 29, 17, 0, 0),
    startDate: DateTime(2019, 9, 29),
    endDate: DateTime(2019, 9, 29),
    type: 1,
    maid: userMaids[1],
    amount: 1100000,
  ),
];
