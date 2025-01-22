import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:lomfu_app/modules/teacher/controller/course_detail_controller.dart';
import 'package:lomfu_app/modules/teacher/models/course_model.dart';
import 'package:lomfu_app/API/api_const.dart';

class CourseDetailsPage extends StatelessWidget {
  CourseDetailsPage({super.key});

  CourseDetailController controller = Get.put(CourseDetailController());

  @override
  Widget build(BuildContext context) {
    CourseModel course = controller.course!;
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(course.title),
            SizedBox(
              height: 20,
            ),
            course.photo != null
                ? Image.network(
                    "${baseUrl}${course.photo}",
                    fit: BoxFit.cover,
                    height: 300,
                  )
                : Icon(
                    Icons.image_not_supported,
                    size: 50,
                  ),
          ],
        ),
      ),
    );
  }
}
