/// Enum `LocalizationLoaderType` specifies the method used to load localization data.
///
/// This enum is used to configure the source type of localization resources,
/// enabling different strategies for loading language files or data in your application.
enum LocalizationLoaderType {
  /// `assets`: Load localization data from local assets.
  ///
  /// Use this loader type when your localization data is stored as part of the
  /// application's assets. This is a common approach for apps with static translations
  /// that do not change post-deployment. Localization files are typically included in
  /// the project's asset folder and bundled into the app package.
  assets,

  /// `http`: Load localization data from a remote server via HTTP.
  ///
  /// This loader type is suitable for applications requiring dynamic localization data
  /// that can be updated independently of the app updates. It fetches translations from
  /// a specified HTTP endpoint, allowing for real-time language updates, A/B testing
  /// of translations, or serving different translations based on user preferences or
  /// other criteria. Ensure secure and efficient data fetching when using this method.
  http,
}
