# bible
Bible is still in early development, contributions by implementing
APIs is welcome!

## Usage
A simple usage example:

```dart
import 'package:bible/bible.dart';

void main() {
  Bible.addKeys({'esvapi': 'APITOKEN'});
  var passage = Bible.queryPassage('John 3:16');
}
```

