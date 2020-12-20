# Contributing

Contributing is fairly easy, if you are only familiar with JavaScript or Java the Dart syntax is similar.

## Start

I would recommend simply cloning a file as a starting point, for example, clone the 'GetBible.dart' file.

After this, rename the class and the `name` of the API. Then go to the corresponding API site and place
all versions offered by that API into the map in the constructor. Afterwards it should look
something like this:

```dart
class APINAME extends BibleProvider {
  APINAME()
      : super('api-name', false, { 
          'akjv',
          'asv',
		  //...
        });
//...
}
```
Note that the second parameter is whether the API requires an API key.

## Implement

Implement the `getPassage` method for the API, the signature
of the method should be as follows:
```dart
  Future<PassageQuery> getPassage(BibleReference query,
      {Map<String, String> parameters, String key, String version}) async {
        // Implementation
      }
```

If you're unfamiliar with dart or JavaScript, the `async` word just indicates
that the function will return a future and may be run asynchronously

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
