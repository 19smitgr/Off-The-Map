import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:off_the_map/views/student_assignment_page.dart';

void main() {
  testWidgets('buttons are all visible', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: StudentAssignmentPage()));
    var textElements = find.text('Current Assignments');
    expect(textElements, findsWidgets);
    tester.ensureVisible(textElements);
  });
}
