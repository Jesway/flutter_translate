## [1.0.0]

- Initial release.

## [1.0.1]

- Removed the flutter_localizations dependency.

## [1.0.2]

- Simplified the localization initialization.

## [1.1.0]

- Implemented a global translate method.
- Removed the static Translate class.
- Localization is now a singleton.

## [1.2.0]

- Implemented pluralization.
- Fixed multiple issues.
- translate, translatePlural and changeLanguage methods are now global.

## [1.2.2]

- Missing localizations now return the full key path.

## [1.2.5]

- Fixed possible exception when adding an extra slash to the ```basePath```

## [1.3.0]

- Implemented the onLocaleChanged callback

## [1.3.1]

- Implemented the localeToString method

## [1.3.2]

- Fixed some callback issues for onLocaleChanged

## [1.4.0]

- Implemented support for automatically saving & restoring the selected locale using shared preferences

## [1.4.0+1]

- Added the Awesome Flutter badge

## [1.4.0+2]

- Fixed the example to adapt the changes to BinaryMessenger (https://github.com/flutter/flutter/pull/38464)

## [1.5.0]

- Fixed the blackscreen issue on startup
- Fixed the iOS issue regarding the device locale
- The current device locale is now used on startup

## [1.5.1]

- Updated the flutter_device_locale dependency to avoid a possible exception
- Updated the example to AndroidX

## [1.5.2]

- Updated the flutter_device_locale version

## [1.5.3]

- Renamed packages, updated license and links

## [1.5.7]

- Updated the examples
- Fixed some issues with flutter_device_locale and swift

## [1.6.0]

- Web applications are now supported
- Updated the examples with web support

## [2.0.0]

- Removed flutter_device_locale dependency
- The native flutter locale retrieval method is now used
- Added support for desktop
- Added examples for windows desktop

## [2.0.1]

- Fixed web support

## [3.0.0]

- Null safety support