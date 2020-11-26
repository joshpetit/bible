import 'Provider.dart';
import 'package:bible/src/model/PassageQuery.dart';

class ESVAPI extends Provider {
  ESVAPI() : super(true, {'esv'});

  @override
  PassageQuery getPassage(String query) {
    return null;
  }
}
