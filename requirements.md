# Requirements: Profile / Account screen + Navigation

Goal:
- Provide a simple Profile / Account screen where users can view and edit basic information. No authentication or persistence required for this exercise.

User stories and acceptance criteria:
1. As a user, I can open a Profile screen from the Order page (bottom link) and from the app Drawer.
   - Acceptance: Tapping the `Profile` link navigates to the profile screen.
2. As a user, I can edit my Full name (required), Email (validated), Phone (optional), and Bio (optional), then tap `Save` to show confirmation.
   - Acceptance: Validation prevents saving when Full name is empty or when Email is invalid.
   - Acceptance: On successful save, a `SnackBar` with confirmation appears.
3. As a developer, navigation to `ProfileScreen` should be testable using widget tests.

Implementation notes:
- Place the screen at `lib/views/profile_screen.dart` and export a `ProfileScreen` Widget.
- Add a button in `OrderScreen` bottom area with key `open_profile_button` to navigate to `ProfileScreen`.
- Ensure `AppDrawer` also navigates to `ProfileScreen`.
- Add tests in `test/widgets/`:
  - `profile_navigation_test.dart` to verify navigation from Order to Profile.
  - `profile_form_test.dart` to verify validation and SnackBar on save.

Testing guidance:
- Use `WidgetTester` to pump the `App()` root widget so drawer and order screen are available.
- Use `tester.tap` and `tester.enterText` for interactions, and `tester.pumpAndSettle()` for animations and navigation.
