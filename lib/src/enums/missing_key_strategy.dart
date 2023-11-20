/// Defines the strategy for handling missing translation keys.
enum MissingKeyStrategy 
{
    /// Use the key itself as the fallback.
    /// This strategy will return the key string when a translation is not found.
    key,

    /// Use the fallback language's translation for the missing key.
    /// If a translation is not found in the selected language, 
    /// the translation from the fallback language will be used.
    fallback,
}