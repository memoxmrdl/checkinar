import fontawesome from '@fortawesome/fontawesome';
import faSearch from '@fortawesome/fontawesome-free-solid/faSearch';
import faUpload from '@fortawesome/fontawesome-free-solid/faUpload';
import faMinusCircle from '@fortawesome/fontawesome-free-solid/faMinusCircle';
import faCheck from '@fortawesome/fontawesome-free-solid/faCheck';

export default class FontAwesome {
  static start() {
    fontawesome.library.add(faSearch);
    fontawesome.library.add(faUpload);
    fontawesome.library.add(faMinusCircle);
    fontawesome.library.add(faCheck);
  }
}
