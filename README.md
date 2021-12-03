# Flutter App Analytics Amplitude Package

Implements support for Amplitude into the [Flutter App Analytics](https://github.com/uptech/flutter_app_analytics) package.

## How to use
```dart
AmplitudeProvider amplitude = AmplitudeProvider(apiKey: '');
Analytics analytics = ...;
analytics.providers = [amplitude];
```

## Testing

### Run Tests

```
flutter test
```

## Generating your mocks

We use build_runner to generate mocks from mockito:

```
flutter pub run build_runner build
```
