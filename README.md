# bible
Bible is still in early development, contributions by implementing
APIs is welcome!

## Usage
This package currently only supports querying these APIs:

| Name | Requires API key|
| ----- | --------- |
| [esvapi](https://api.esv.org/) | yes |
| [getbible](https://getbible.net/api) | no |

Simple example:

```dart
import 'package:bible/bible.dart';
...
var passage = await Bible.queryPassage('John 3:16'); // Will default to ASV and getbible
print(passage.passage) // The text from the query
```
An example requiring an API key 

```dart
import 'package:bible/bible.dart';
...
  Bible.addKeys({'esvapi': 'APITOKEN'});
  var passage = Bible.queryPassage('John 3:16');
}
```

