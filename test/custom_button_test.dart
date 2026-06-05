import 'package:event_hub/features/widgets/custom_button_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Button click test',
      (WidgetTester tester) async {

    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButtonAuth(
            title: 'Login',
            color: Colors.orange,
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(pressed, true);
  });
}