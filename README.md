<!--
	README.md
	用途：为 Sandwich Shop Flutter 演示应用提供清晰的说明、安装步骤和使用指南。
	语言：中文（简体）
-->

# Sandwich Shop App

> 一个教学用途的 Flutter 示例应用，演示小部件、状态管理、存储库分离和测试。此仓库适合作为学习 Flutter 架构与单元/小部件测试的练习项目。

## 功能简介
 
---

# Sandwich Shop App (English README)

This repository contains a small Flutter sample app used for teaching widget composition, state management, separation of concerns (UI vs repository), and testing.

## Overview
The app models a simple sandwich ordering flow with these features:

- Select sandwich size: Footlong (1ft) or 6-inch
- Choose bread type: White, Wheat, or Rye
- Toggle whether the sandwich should be toasted
- Add or remove items from the current order (subject to a max quantity)
- Enter a free-text order note
- See the computed total price for the current order

This project is intentionally small and structured to show how business logic can be separated into repository classes so it can be unit-tested independently of UI widgets.

## Quick start (Development)

Prerequisites
- Flutter SDK installed (see https://flutter.dev/docs/get-started/install)
- An emulator or a connected device (`flutter devices`)

Clone and run

```powershell
git clone <your-repo-url>
cd sandwich_shop
flutter pub get
flutter run
```

Run tests

```powershell
flutter test
```

## How to use the app

1. Launch the app on a device or emulator.
2. Use the Add / Remove buttons to change the order quantity. Buttons are disabled when the order reaches 0 or the configured maximum.
3. Toggle between Footlong and 6-inch to change the sandwich size.
4. Choose a bread type from the dropdown.
5. Toggle the toasted switch to mark the sandwich as toasted or not.
6. Enter notes (e.g., “no onions”) in the text field.
7. The Total price displays the calculated cost based on size and quantity.

## Project structure

```
lib/
	├─ main.dart                # Main UI and screens
	├─ views/
	│   └─ app_styles.dart      # Centralized text styles
	├─ repositories/
	│   ├─ order_repository.dart   # Business logic for order quantity
	│   └─ pricing_repository.dart # Pricing calculation logic
test/
	├─ widget_test.dart         # Widget tests (updated)
	└─ repositories/
			└─ order_repository_test.dart
```

## Design notes

- Business logic is encapsulated in repository classes (`OrderRepository`, `PricingRepository`) so UI code (`OrderScreen`) is simplified and easier to test.
- Styles are placed in `views/app_styles.dart` to demonstrate centralizing UI constants (similar to CSS in web projects).
- Tests include unit tests for repositories and widget tests for interactions. Keep tests updated when refactoring logic.

## Known limitations & future improvements

- Pricing currently uses integer GBP values (e.g., 11 and 7). For real currency support, switch to `double` and use proper formatting/localization.
- Persistent storage (saving orders to disk) is not implemented by default. Consider adding `path_provider` + a `FileService` for persistence.
- UI aesthetics are minimal — could be improved with Material theming, icons, and responsive layout.

## Contributing

1. Fork the repository and create a feature branch.
2. Run tests and ensure they pass: `flutter test`.
3. Submit a pull request with a clear description of changes.

## Contact

If you have questions, please open an issue in the repository or contact the maintainer via their GitHub profile.

---

If you want, I can create multiple logical git commits for the changes made in this exercise (e.g., add repositories, add styles, tests). Reply `commit and push` to let me create and push commits from this workspace.
- 选择三明治尺寸：Footlong（1英尺）或 6-inch（6英寸）
- 选择面包类型：White / Wheat / Rye
- 切换是否烘烤（toasted）
- 添加或移除三明治（受最大数量限制）
- 为订单添加备注（notes）
- 显示订单总价（根据尺寸与数量计算）

## 快速开始（开发者）
先决条件：
- 已安装 Flutter SDK（请参阅 https://flutter.dev/docs/get-started/install ）
- 一个可用的设备或模拟器（`flutter devices` 可列出）

在项目根目录打开终端后运行：

```powershell
cd e:\flutter_application_1
flutter pub get
flutter run
```

运行测试：

```powershell
flutter test
```

## 如何使用应用（用户指南）
1. 启动应用后，你会看到应用栏“Sandwich Counter”。
2. 屏幕中间显示当前订单数量与相应的 emoji（例如 `3 Footlong sandwich(es): 🥪🥪🥪`）。
3. 使用 `Add` / `Remove` 按钮增加或减少数量。按键在达到最大/最小值时会被禁用以防越界。
4. 切换 Footlong / 6-inch 控件以更改三明治尺寸。
5. 使用下拉菜单选择面包类型，输入框可添加订单备注。
6. 切换 `toasted` 开关以标记是否烘烤（演示状态绑定）。
7. 界面底部会显示基于数量与尺寸计算的总价。

## 项目结构
```
lib/
	├─ main.dart                # 主要 UI 与页面
	├─ views/
	│   └─ app_styles.dart      # 集中样式（TextStyle 等）
	├─ repositories/
	│   ├─ order_repository.dart   # 管理数量逻辑（增/减/边界）
	│   └─ pricing_repository.dart # 计算总价逻辑
test/
	├─ widget_test.dart         # 现有小部件测试（已更新）
	└─ repositories/
			└─ order_repository_test.dart
```

## 主要设计决策
- 将业务逻辑（数量与定价）移动到 `repositories/`，便于单元测试与复用。
- 使用简单样式中心 `views/app_styles.dart` 来演示如何统一管理文本样式。
- 使用 `Widget` + `StatefulWidget` 展示状态管理与 UI 更新（`setState`）。

## 已知问题与改进方向
- 当前价格使用整数英镑（如 11 和 7），如需小数或税率支持，可改用 `double` 并加入格式化显示。
- 文件保存（持久化订单）尚为可选功能；如果需要可添加 `path_provider` 并实现 `FileService`。
- UI 还可进一步美化（Card、图标、响应式布局），并增加更多 widget 测试覆盖边界条件。

## 贡献与提交
- 请在开发前创建分支并在完成后提交到远程。提交信息请简洁描述更改点，例如：`Add pricing repository`、`Refactor OrderScreen to use repository`。

## 联系方式
- 作者/维护者：请在仓库中留下联系信息或通过 GitHub profile 联系。

---

如果你希望，我可以把这些更改按逻辑分组成多次 git 提交并推送到远程（需要你允许我在工作区运行 git 命令）。
