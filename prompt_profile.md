Feature prompt: Add a Profile / Account screen

You are an AI assistant implementing a small profile/account UI for a Flutter demo app (no real authentication or persistence required). The screen should let the user view and edit simple fields: Full name, Email, Phone (optional), and a short bio. Include validation for email format and required name field. Add a Save button that shows a SnackBar confirming save (no real backend).

Integration details:
- Add a new `ProfileScreen` (if not already present) under `lib/views/profile_screen.dart`.
- Add a navigation link from the Order screen bottom area to this `ProfileScreen` (temporary direct navigation). Use a key `open_profile_button` on the button for tests.
- Update app navigation so that the `AppDrawer` can reach `ProfileScreen` as well.

Testing:
- Add a widget test `test/widgets/profile_navigation_test.dart` that pumps the app, taps the Order->Profile button, and asserts the profile UI appears.
- Add a widget test for the form save flow: fill name/email, tap Save, expect SnackBar.

Deliverables:
- `lib/views/profile_screen.dart` (UI + validation)
- `test/widgets/profile_navigation_test.dart`
- `prompt_profile.md` and `requirements.md` / update to repo
