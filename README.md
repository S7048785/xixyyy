# 习讯云签到 (XixyyySign)

XixyyySign 是一个基于 Flutter 开发的第三方**习讯云**签到辅助工具（APP）。它可以帮助用户在手机上方便地进行习讯云的账号登录、查看当月签到状态，并支持自定义位置（经纬度和详细地址）进行打卡签到。

## 🌟 主要功能

- **账号登录**：支持使用习讯云账号（通常为学号）、密码及学校 ID 进行登录。
- **状态查询**：首页自动获取并展示今日签到状态以及当月连续签到情况。
- **位置模拟签到**：支持在 APP 内手动输入指定的经度、纬度以及详细地址，进行自定义位置打卡签到。
- **签到记录**：内置查看历史签到记录及相关信息的功能页面。
- **现代化 UI**：基于 `shadcn_ui` 和 `styled_widget` 打造，界面简洁直观，支持深浅色主题适配。

## 🛠 技术栈

- **框架**: [Flutter](https://flutter.dev/) (SDK ^3.10.7)
- **状态管理与路由**: [GetX](https://pub.dev/packages/get)
- **网络请求**: [Dio](https://pub.dev/packages/dio)
- **UI 组件库**: [shadcn_ui](https://pub.dev/packages/shadcn_ui), [styled_widget](https://pub.dev/packages/styled_widget)
- **数据持久化**: [shared_preferences](https://pub.dev/packages/shared_preferences)
- **加密处理**: [encrypt](https://pub.dev/packages/encrypt), [pointycastle](https://pub.dev/packages/pointycastle)

## 项目截图

| <img width="495" height="881" alt="img_1" src="https://github.com/user-attachments/assets/2a1a3e0e-f853-41bf-bc66-20c612cd2dea" />
 | ![img_2](https://github.com/user-attachments/assets/3b1aea27-331e-453e-8104-4fc3983a0ca4)
 | <img width="495" height="881" alt="img_3" src="https://github.com/user-attachments/assets/d91ef3de-c383-4e69-83ed-bfcbdbc78fd9" />
 |
|-----------------------------------------------------|----------------------------------------------------| -------------------------------------- |


## 🚀 如何运行与开发

### 环境要求

- Flutter SDK (>=3.10.7)
- Dart SDK
- Android / iOS 开发环境 (Android Studio / Xcode)

### 本地编译运行

1. **克隆项目到本地**

   ```bash
   git clone https://github.com/S7048785/xixyyy.git
   cd xixyyy_sign
   ```

2. **获取 Flutter 依赖**

   ```bash
   flutter pub get
   ```

3. **运行项目**
   连接真机或模拟器后，执行：
   ```bash
   flutter run
   ```

## 📱 APP 使用指南

1. **登录系统**：
   打开 APP 后，在登录界面输入你的 **习讯云账号（学号）**、**密码** 以及对应的 **学校 ID**，点击登录。(学校 ID 在 [school_id.json](https://github.com/S7048785/xixyyy/blob/main/school_id.json) 中查看)
2. **查看状态**：
   登录成功后将进入首页，上方卡片会展示你今日的签到状态（“已签到”或“未签到”）。
3. **设置签到位置**：
   - 在首页点击展开 **“位置模拟”** 面板。
   - 分别输入你需要打卡位置的 **经度**、**纬度** 和 **详细地址**。
4. **一键签到**：
   确认位置信息无误后，点击屏幕中央的签到按钮（水波纹动画按钮）发起签到请求。成功或失败会有对应的 Snackbar 弹窗提示。

## 🙏 致谢

本项目中使用的习讯云相关 API 接口和加密算法参考自开源项目 **xixunyunsign**。
特别感谢其作者及贡献者提供的参考与灵感！

- 仓库地址：[Turris-Babel/xixunyunsign](https://github.com/Turris-Babel/xixunyunsign)

## ⚠️ 免责声明

1. 本项目仅供学习和研究 Flutter、Dart 技术交流使用。
2. 请勿将本项目用于任何商业用途或违反学校/企业规章制度的代签、作弊等行为。
3. 因使用本软件而产生的任何账号封禁、惩罚或其他意外后果，由使用者自行承担，开发者概不负责。
