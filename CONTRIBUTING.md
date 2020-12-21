# Contributing

Contributing is fairly easy, if you are only familiar with JavaScript or Java the Dart syntax is similar.

## Start
I would recommend simply copying a file as a starting point, for instance the 'ESVAPI.dart' file.

The API implementations are within the `api` package:
```
.
├── lib
│   ├── bible.dart
│   ├── providers.dart
│   └── src
│       ├── api
│       │   ├── Bible.dart
│       │   ├── BibleProvider.dart
│       │   ├── ESVAPI.dart
│       │   └── GetBible.dart
│       └── model
│           └── PassageQuery.dart
└── test
    ├── provider_test.dart
    └── secrets.dart
```
So copy ESVAPI.dart and paste it into the same directory as `APINAME.dart`.

After this, within the file rename the class and the `name` of the API.

### Implementing the Constructor
The first parameter is the name of the API, the second is whether it requires an API key,
and the third is the versions offered by the service.
To get the versions offered go to the site and copy
all translations offered by that API (if there are lot just include the english versions) into the set in the constructor.

It should look something like this afterwards:

```dart
class APINAME extends BibleProvider {
  APINAME()
      : super('apiname', false, { 
          'akjv',
          'asv',
		  //...
        });
//...
}
```

## Implement getPassage

Implement the `getPassage` method for the API, the signature
of the method should be as follows:
```dart
  Future<PassageQuery> getPassage(BibleReference query,
      {Map<String, String> parameters, String key, String version}) async {
        // Implementation
      }
```

If you're unfamiliar with dart or JavaScript, the `async` word just indicates
that the function will return a future and may be run asynchronously.
The Dart documentation is very thorough so you can figure out how to do what's
needed by looking at APIs already implemented and google.

After implementing the `getPassage` method return a PassageQuery object.
**Note:** A PassageQuery object has an optional field called `verses`, this
field is if the API provides the verses in an array. If this is the case,
concatenate all of them with the `StringBuffer` class (equivalent of StringBuilder
in Java) and pass the array to the verses field. 

After parsing the query, pass the original json response to the `extra` parameter
in the PassageQuery. It should look something like this: 
```dart
  return PassageQuery.fromProvider(passage, reference,
      verses: verses, extra: extra);
```

Once finishing, you can add a test in the test file, and (most importantly!) add the provider
to the `_providers` array within the `Bible.dart` file.

And done! Once finished you can add the new provider to the README and add a short doc comments
to the class name and the `getPassage` method.

## Testing

When writing a test you can just copy the test case for `getbible` in the 'Test API Providers' group
and change the needed names and fields. When running tests you need to create a file named
secrets.dart with a varaible called 'keys'. like this:
```dart
const keys = {
'api-name': 'api-key',
'other-api': 'other-key',
};
```

if the API you implement requires a key, when writing a test, make sure to write a test
to ensure the API key is included before running the test, such as this:
```dart
if (bible.getKey('api-name') == null) {
    return;
}
```

