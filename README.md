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
An example requiring an API key 

```dart
Bible.addKeys({'esvapi': 'APITOKEN'});
var passage = await Bible.queryPassage('John 3:16', providerName:'esvapi');
```
You can also pass API keys on queries alongside parameters for the specific API

```dart
...
Bible.addKeys({'esvapi': 'APITOKEN'});
var passage = await Bible.queryPassage('John 3:16', key: 'APITOKEN', parameters: {'Map': 'of params'});
```
You can specify bother the version and provider with optional parameter.
```dart
var passage = await Bible.queryPassage('John 3:16', providerName: 'getbible', version: 'asv');
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
This is the same as doing using the providerName parameter but if you were to create
your own provider you could pass it to the function.

**Note**: If you create your own provider please consider contributing it back to the repository :).

## Contributing
Implementing an API isn't hard, so I'm open to having people implementing and sending pull requests
for different bible APIs. This is a great first issue and doesn't require extension dart knowledge, just copy a provider already created and go from there!

APIs that need implementing:


| Name |  Difficulty|
| ----- | --------- |
| [bibleapi](https://bible-api.com/) | easy |
| [bibleorg](https://labs.bible.org/api_web_service) | easy |
| [nltapi](http://api.nlt.to/) | easy |
| [bibliaapi](https://bibliaapi.com/docs/) | moderate |
| [scriptureapi](https://scripture.api.bible/) | hard |
