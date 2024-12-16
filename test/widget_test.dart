import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:newsletter/main.dart';
import 'package:newsletter/src/core/config/dependencies.dart';
import 'package:newsletter/src/core/helper/Internet_connection_mock.dart';
import 'package:newsletter/src/core/helper/firebase_helper.dart';
import 'package:newsletter/src/data/models/newsletter/newsletter_remote.dart';
import 'package:newsletter/src/data/services/newsletter/local/newsletter_service_local.dart';
import 'package:newsletter/src/data/services/newsletter/remote/newsletter_service_remote.dart';
import 'package:newsletter/src/data/services/newsletter/remote/newsletter_service_remote_mock.dart';
import 'package:uuid/uuid.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Set up mock dependencies.
    HybridMockBindings().dependencies();
  });

  group('Newsletter Tests', () {
    testWidgets('Testing offline to online and local/remote sync',
        (WidgetTester tester) async {
      // Pump the main app widget.
      await tester.pumpWidget(const MainApp());

      // Verify the loading state.
      expect(find.text('Loading newsletter'), findsOneWidget);
      await tester.pumpAndSettle();

      // Verify the initial offline state.
      expect(find.text('Offline'), findsOneWidget);

      // Retrieve services for assertions.
      final remoteService =
          Get.find<NewsletterServiceRemote>() as NewsletterServiceRemoteMock;
      final localService = Get.find<NewsletterServiceLocal>();

      expect(remoteService.subject.valueOrNull, null);
      expect(localService.subject.value.length, 10);

      // Simulate online connection.
      final internetConnection =
          Get.find<InternetConnection>() as InternetConnectionMock;
      internetConnection.setConnectionStatus(true);

      await tester.pumpAndSettle();
      expect(find.text('Synchronizing'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('Online'), findsOneWidget);

      // Assert data state after synchronization.
      expect(remoteService.subject.valueOrNull, null);
      expect(localService.subject.value.length, 10);

      // Create a new newsletter and validate UI changes.
      await createAndVerifyNewsletter(tester, attempt: 0);

      // Test sorting functionality.
      await toggleSortOrder(tester, ascending: true);
      await toggleSortOrder(tester, ascending: false);

      // Verify the new entry in the list.
      expect(find.text('Title mock 0'), findsOneWidget);
      expect(remoteService.subject.value.length, 11);
      expect(localService.subject.value.length, 11);

      // Simulate going offline.
      internetConnection.setConnectionStatus(false);
      await tester.pumpAndSettle();
      expect(find.text('Offline'), findsOneWidget);

      // Create another newsletter while offline.
      await createAndVerifyNewsletter(tester, attempt: 1);
      expect(find.text('Title mock 1'), findsOneWidget);
      expect(remoteService.subject.value.length, 11);
      expect(localService.subject.value.length, 12);

      // Simulate going online again.
      internetConnection.setConnectionStatus(true);

      // Create another newsletter while online.
      await createAndVerifyNewsletter(tester, attempt: 2);
      expect(remoteService.subject.value.length, 13);
      expect(localService.subject.value.length, 13);
    });

    testWidgets('Testing Firebase helper', (WidgetTester tester) async {
      final fakeFirestore = FakeFirebaseFirestore();

      final doc = await FirebaseHelper.insertDocument(
          'newsletter',
          NewsletterRemote(
                  title: 'Test Firebase',
                  category: 'Test',
                  summary: 'This is my Firebase Integration test',
                  link: 'newsletter.caina.dev',
                  createdAt: DateTime.now(),
                  remoteId: null,
                  uuid: Uuid().v4())
              .toJson(),
          firestore: fakeFirestore);

      expect((await doc.get()).exists, true);

      final collectionStream = FirebaseHelper.getCollectionStream('newsletter',
          firestore: fakeFirestore);
      // final collectionStreamListen =
      collectionStream.listen((data) {
        expect(data.docs.length, 1);
        expect(data.docs.first.data()['title'], 'Test Firebase');
      });
    });
  });
}

/// Creates a newsletter using the provided [WidgetTester] and verifies the process.
Future<void> createAndVerifyNewsletter(WidgetTester tester,
    {required int attempt}) async {
  // Tap the add button to open the creation screen.
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle();
  expect(find.text('Create Newsletter'), findsOneWidget);

  // Fill the newsletter form fields.
  await enterTextIntoField(tester, 'Title', 'Title mock $attempt');
  await enterTextIntoField(tester, 'Category', 'Category $attempt');
  await enterTextIntoField(
      tester, 'Summary', '0123456789012345678910 $attempt');
  await enterTextIntoField(tester, 'Link', 'link$attempt.com');

  // Submit the form.
  await tester.tap(find.text('Create'));
  await tester.pumpAndSettle(const Duration(seconds: 2));
}

/// Toggles the sort order of newsletters.
Future<void> toggleSortOrder(WidgetTester tester,
    {required bool ascending}) async {
  final buttonText = ascending ? 'Asc ↑' : 'Desc ↓';
  await tester.tap(find.text(buttonText));
  await tester.pumpAndSettle();
}

/// Enters text into a [TextField] identified by its [labelText].
Future<void> enterTextIntoField(
    WidgetTester tester, String labelText, String text) async {
  final fieldFinder = find.byWidgetPredicate(
    (widget) =>
        widget is TextField && widget.decoration?.labelText == labelText,
  );
  await tester.enterText(fieldFinder, text);
  await tester.pump();
}
