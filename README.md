[<img src="https://github.com/jesway/flutter_translate/raw/master/resources/images/flutter_translate.png" />](https://github.com/jesway/flutter_translate/)

[![Build Status](https://travis-ci.org/jesway/flutter_translate.svg)](https://travis-ci.org/jesway/flutter_translate)
[![pub package](https://img.shields.io/pub/v/flutter_translate.svg?color=important)](https://pub.dev/packages/flutter_translate)
<a href="https://github.com/Solido/awesome-flutter">
   <img alt="Awesome Flutter" src="https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true" />
</a>
[![License: MIT](https://img.shields.io/badge/License-MIT-ff69b4.svg)](https://github.com/jesway/flutter_translate/blob/master/LICENSE)
[![Flutter.io](https://img.shields.io/badge/Flutter-Website-deepskyblue.svg)](https://flutter.io/)

---

Flutter Translate is a fully featured localization / internationalization (i18n) library for Flutter.

It lets you define translations for your content in different languages and switch between them easily.

## Example
<img src="https://raw.githubusercontent.com/jesway/flutter_translate/master/resources/gifs/flutter_translate_screen.gif" width="300"/>

## Features

* Very easy to use
* ```Pluralization``` support
* ```Static keys``` support with [flutter_translate_gen](https://github.com/jesway/flutter_translate/wiki/3.-Generating-statically-typed-localization-keys)
* Supports both ``languageCode (en)`` and ``languageCode_countryCode (en_US)`` locale formats 
* Automatically ```save & restore``` the selected locale [with a simple implementation](https://github.com/jesway/flutter_translate/wiki/2.-Automatically-saving-&-restoring-the-selected-locale)
* Full support for ```right-to-left``` locales
* ``Fallback`` locale support in case the system locale is not unsupported.
* Supports both ``inline or nested`` JSON

## Documentation

Complete documentation is available [on the wiki page](https://github.com/jesway/flutter_translate/wiki).

To get started please see [Installation, Configuration & Usage](https://github.com/jesway/flutter_translate/wiki/1.-Installation,-Configuration-&-Usage).

## Examples

* [Example using dynamic keys](https://github.com/jesway/flutter_translate/tree/master/example)
* [Example using static keys](https://github.com/jesway/flutter_translate/tree/master/example_static_keys)

## License

MIT License - Copyright (c) 2019 [Jesway](https://jesway.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
