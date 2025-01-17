import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/config/constants/api_const.dart';
import 'package:lomfu_app/modules/teacher/controller/course_controller.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/widgets/custom_app_bar.dart';

class CourseListPage extends StatelessWidget {
  final _controller = Get.put(CourseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("Courses"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                if (_controller.loading.value)
                  return const Center(child: CircularProgressIndicator());

                if (_controller.courselist.isEmpty)
                  return const Center(child: Text("No Courses Found"));

                return _buildSearchResults();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _controller.courselist.length,
      itemBuilder: (context, index) {
        final course = _controller.courselist[index];
        return Card(
          elevation: 8,
          color:
              Get.isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            onTap: () {
              print("Hi");
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network(
                      baseUrl + (course.photo ?? ''),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported);
                      },
                    ),
                  ),
                  title: Text(
                    course.title,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.overview,
                        maxLines: 2,
                      ),
                      Text(
                        course.createdAt,
                      ),
                    ],
                  ),
                  trailing: Text(
                    course.subject,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
