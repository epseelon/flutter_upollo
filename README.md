# flutter_upollo

This plugin integrates Upollo (formerly Userwatch) into your apps to turn repeat signups and account sharers and more into happy paying customers.

## Getting Started

### Add dependency

```
flutter pub add flutter_upollo
```

or add the following line to your pubspec.yaml:

```
flutter_upollo: ^0.1.0
```

### Android configuration

This plugin requires a minimum Android SDK version of 21. So in your android/app/build.gradle file, add the following line:

```
minSdkVersion 21
```

### iOS configuration

This plugin requires a minimum iOS version of 12.0. So at the top of your Podfile, set platform to 12.0:

```
platform :ios, '12.0'
```

### Initialization

In your `main.dart` file, make your `main()` function async, and add the following lines:

```
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterUpollo.init(
    publicApiKey: const String.fromEnvironment('UPOLLO_KEY'),
  );
  runApp(const MyApp());
}
```

In this case, you pick up the public API key from environment variables, but you can decide where you get this value from.

## Usage

Once the plugin is initialized, you can use 2 methods:
- [`assess`](https://upollo.ai/docs/examples/assess) to send information to the server about the current user and the event you are tracking, and get an immediate recommendation from the server about potential account sharing and repeat signups.
- [`track`](https://upollo.ai/docs/examples/verify) to send information to the server without getting any recommendation back right away, but to get a token you can pass to your backend to make further decisions.

Both of these methods let you pass a `UserInfo` object and an event type.

For example, after your user has logged in, you can do the following:

```dart
final result = await FlutterUpollo.instance.assess(
  eventType: EventType.login,
  userInfo: UserInfo(
    userId: 'abc1234', 
    userEmail: 'user@example.org',
  ),
);
if(result != null && result.action != Outcome.permit) {
  ...
}
```

For more information about what Upollo does, here is the [documentation](https://upollo.ai/docs/).

## Running the example app

The example app expects to find an environment variable called `UPOLLO_KEY` and containing your Upollo public API key.

You can set this environment variable by running flutter with the following command line argument:
    
```
--dart-define=UPOLLO_KEY=[Public API Key from Upollo dashboard without squared brackets]
```