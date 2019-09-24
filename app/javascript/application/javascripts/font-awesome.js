import fontawesome from '@fortawesome/fontawesome';
import faSearch from '@fortawesome/fontawesome-free-solid/faSearch';
import faUpload from '@fortawesome/fontawesome-free-solid/faUpload';

export default class FontAwesome {
  static start() {
    fontawesome.library.add(faSearch);
    fontawesome.library.add(faUpload);
  }
}
