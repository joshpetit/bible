# bible
This package provides a simple interface for interacting with different bible APIs.

## Usage
This package currently only supports querying these APIs:

| Name | Requires API key|
| ----- | --------- |
| [esvapi](https://api.esv.org/) | yes |
| [getbible](https://getbible.net/api) | no |

Simple example:

```dart
import 'package:bible/bible.dart' as Bible;
...
var passage = await Bible.queryPassage('John 3:16'); // Will default to the GetBible API
print(passage.passage) // The text from the query
```
An example requiring an API key:

```dart
Bible.addKeys({'esvapi': 'APITOKEN'});
var passage = await Bible.queryPassage('John 3:16', providerName:'esvapi');
```
You can also pass the API key as an optional parameter:

```dart
Bible.addKeys({'esvapi': 'APITOKEN'});
var passage = await Bible.queryPassage('John 3:16', key: 'APITOKEN');
```
You can also pass query parameters through a map. See specific API documentation for those parameters.
```dart
Bible.addKeys({'esvapi': 'APITOKEN'});
var passage = await Bible.queryPassage('John 3:16', key: 'APITOKEN', parameters: {'Map': 'of params'});
```
You can specify the version or provider with optional parameters.
```dart
var passage = await Bible.queryPassage('John 3:16', providerName: 'getbible', version: 'asv');
```
**Note:**The providerName coresponds to that in the table at the beginning of this documentation.

Every time a passage is queried, the [reference_parser](https://pub.dev/packages/reference_parser) library tries to
parse the query (i.e mispelling will automatically be corrected, shortened verse forms will be allowed). To prevent
this just pass `false` to the `useParser` parameter.

```dart
var passage = await Bible.queryPassage('John 3:16', useParser: false);
```

If you import the providers library you can use can directly query every the providers or pass them
to the queryPassage function as an optional parameter
```dart
import 'package:bible/bible.dart' as Bible;
import 'package:bible/providers.dart';
//...
var prov = GetBible();
var passage = await Bible.queryPassage('John 3:16', provider: prov);
```
This is the same as using the providerName parameter but if you were to create
your own provider you could pass it to the function.

**Note**: If you create your own provider please consider contributing it back to the repository :).

## Contributing
Implementing an API isn't hard, so I'm open to having people implementing and sending pull requests
for different bible APIs. This is a great first issue and doesn't require extensive dart knowledge, just copy a provider already created and go from there!

APIs that need implementing:


| Name |  Difficulty|
| ----- | --------- |
| [bibleapi](https://bible-api.com/) | easy |
| [bibleorg](https://labs.bible.org/api_web_service) | easy |
| [nltapi](https://api.nlt.to/) | easy |
| [bibliaapi](https://bibliaapi.com/docs/) | moderate |
| [scriptureapi](https://scripture.api.bible/) | hard |

For more specific information look at the contributing guidlines.
