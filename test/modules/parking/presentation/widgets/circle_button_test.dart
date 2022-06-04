import 'package:a_parking_flutter/app/models/parking/presentation/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mock_material_app_tester.dart';

void main() {   

  group('circle_button_test', () {
    
    testWidgets('should build without exploding', (tester) async {
      await tester.pumpWidgetWithApp(
        CircleButton(onPressed: () => {}),
      );

      expect(find.byType(CircleButton), findsOneWidget);
    });   

    testWidgets(
      'should execute onPressed when button is pressed',
      (tester) async { 

        bool buttonWasPressed = false;
        await tester.pumpWidgetWithApp(
          Material(
            child: CircleButton(onPressed: () => buttonWasPressed = true),
          ),
        );

        final onPressed = find.byType(CircleButton);
        await tester.tap(onPressed);
        await tester.pump(); 

        expect(buttonWasPressed, true);
      },
    );
  });
}