import '../constant.dart';
import 'package:flutter/material.dart';
import 'package:ternav_icons/ternav_icons.dart';

import '../model/course_model.dart';
import '../model/planing_model.dart';
import '../model/statistics_model.dart';

final List<Course> course = [
  Course(
      text: "Balance",
      imageUrl: "images/pic/1.png",
      backImage: "images/box/box1.png",
      color: kDarkBlue),
  Course(
      text: "Vehicles",
      imageUrl: "images/pic/2.png",
      backImage: "images/box/box2.png",
      color: kOrange),
  Course(
      text: "Book Now",
      imageUrl: "images/pic/3.png",
      backImage: "images/box/box3.png",
      color: kGreen),
  Course(
      text: "Fees & Payment",
      imageUrl: "images/pic/5.png",
      backImage: "images/box/box5.png",
      color: kYellow),
  Course(
      text: "Profile",
      imageUrl: "images/pic/4.png",
      backImage: "images/box/box4.png",
      color: kYellow),
];
