import fontawesome from '@fortawesome/fontawesome';
import faUpload from '@fortawesome/fontawesome-free-solid/faUpload';
import faMarkerAlt from '@fortawesome/fontawesome-free-solid/faMapMarkerAlt';
import faUsers from '@fortawesome/fontawesome-free-solid/faUsers';
import faSortNumeric from '@fortawesome/fontawesome-free-solid/faSortNumericUp';
import faMobile from '@fortawesome/fontawesome-free-solid/faMobileAlt';
import faCalendarAlt  from '@fortawesome/fontawesome-free-solid/faCalendarAlt';
import faMinusCircle  from '@fortawesome/fontawesome-free-solid/faMinusCircle';
import faCheck  from '@fortawesome/fontawesome-free-solid/faCheck';

export default class FontAwesome {
  static start() {
    fontawesome.library.add(faUpload);
    fontawesome.library.add(faMarkerAlt);
    fontawesome.library.add(faUsers);
    fontawesome.library.add(faSortNumeric);
    fontawesome.library.add(faMobile);
    fontawesome.library.add(faCalendarAlt);
    fontawesome.library.add(faMinusCircle);
    fontawesome.library.add(faCheck);
  }
}
