/**
 * NewsArticle.cfc
 *
 * @author Todd Sayre
 * @date 2017-07-07
 **/
component accessors=true output=false persistent=false {

  // This is the pageID value of a News Article custom element record
  property name='pageID' type='numeric';
  property name='formID' type='numeric';
  property name='formName' type='string';
  // These are the fields in the News Article custom element
  property name='considerForUniversityHomepage'      type='numeric';
  property name='contactEmail'                       type='string';
  property name='contactName'                        type='string';
  property name='contactPhone'                       type='string';
  property name='content'                            type='string';
  property name='datePublished'                      type='string';
  property name='lblBusiness'                        type='string';
  property name='lblCHP'                             type='string';
  property name='lblEducation'                       type='string';
  property name='lblEngineering'                     type='string';
  property name='lblLaw'                             type='string';
  property name='lblLiberalArts'                     type='string';
  property name='lblMedicine'                        type='string';
  property name='lblMercerUniversity'                type='string';
  property name='lblMusic'                           type='string';
  property name='lblNews'                            type='string';
  property name='lblNursing'                         type='string';
  property name='lblPenfield'                        type='string';
  property name='lblPharmacy'                        type='string';
  property name='lblTheology'                        type='string';
  property name='lblWorkingAdultPrograms'            type='string';
  property name='showInBusinessNews'                 type='numeric';
  property name='showInCHPNews'                      type='numeric';
  property name='showInEducationNews'                type='numeric';
  property name='showInEngineeringNews'              type='numeric';
  property name='showInLawNews'                      type='numeric';
  property name='showInLiberalArtsNews'              type='numeric';
  property name='showInMedicineNews'                 type='numeric';
  property name='showInMusicNews'                    type='numeric';
  property name='showInNursingNews'                  type='numeric';
  property name='showInPenfieldNews'                 type='numeric';
  property name='showInPharmacyNews'                 type='numeric';
  property name='showInTheologyNews'                 type='numeric';
  property name='showInWorkingAdultProgramsNews'     type='numeric';
  property name='showOnBusinessHomepage'             type='numeric';
  property name='showOnCHPHomepage'                  type='numeric';
  property name='showOnEducationHomepage'            type='numeric';
  property name='showOnEngineeringHomepage'          type='numeric';
  property name='showOnLawHomepage'                  type='numeric';
  property name='showOnLiberalArtsHomepage'          type='numeric';
  property name='showOnMedicineHomepage'             type='numeric';
  property name='showOnMusicHomepage'                type='numeric';
  property name='showOnNewsHomepage'                 type='numeric';
  property name='showOnNursingHomepage'              type='numeric';
  property name='showOnPenfieldHomepage'             type='numeric';
  property name='showOnPharmacyHomepage'             type='numeric';
  property name='showOnTheologyHomepage'             type='numeric';
  property name='showOnUniversityHomepage'           type='numeric';
  property name='showOnWorkingAdultProgramsHomepage' type='numeric';
  property name='summary'                            type='string';
  property name='summaryHeaderPhoto'                 type='string';
  property name='title'                              type='string';

  _ = new Underscore();
  jSoup = createObject('java', 'org.jsoup.Jsoup');
  contentHTMLFragment = 0;

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public any function init () {
    if (1 == ArrayLen(ARGUMENTS)) {
      // WriteDump(ARGUMENTS[1]);
      if (IsStruct(ARGUMENTS[1])) {
        if (StructKeyExists(ARGUMENTS[1], 'Values')) {
          StructAppend(ARGUMENTS[1], ARGUMENTS[1].Values);
          StructDelete(ARGUMENTS[1], 'Values');
        }
        setFromStruct(ARGUMENTS[1]);
      }
    }
    return this;
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██    ██ ██████  ██      ██  ██████
  ██   ██ ██    ██ ██   ██ ██      ██ ██
  ██████  ██    ██ ██████  ██      ██ ██
  ██      ██    ██ ██   ██ ██      ██ ██
  ██       ██████  ██████  ███████ ██  ██████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public string function importableContent() {
    return new HTMLFragment(getContent()).importableHTML();
  }

  // public any function cleanContentDOM () {
  //   return new FormattedTextBlock(getContent()).cleanDOM();
  // }

  // public array function cleanImages () {
  //   return new FormattedTextBlock(getContent()).cleanImages();
  // }

  // public array function cleanLinks () {
  //   return new FormattedTextBlock(getContent()).cleanLinks();
  // }

  // public any function contentDOM () {
  //   return new FormattedTextBlock(getContent()).getDOM();
  // }

  public any function images () {
    return contentHTMLFragment.images();
  }

  public any function links () {
    return contentHTMLFragment.links();
  }

  public void function setContent (required string newContent) {
    // writeDump(newContent);
    content = newContent;
    contentHTMLFragment = new HTMLFragment(newContent);
  }

  public array function taxonomyArray () {
    var taxonomy = [];

    if (isTruthy(getShowInBusinessNews()) || isTruthy(getShowOnBusinessHomepage())) {
      ArrayAppend(taxonomy, 'Business & Economics');
    }
    if (isTruthy(getShowInCHPNews()) || isTruthy(getShowOnCHPHomepage())) {
      ArrayAppend(taxonomy, 'Health Professions');
    }
    if (isTruthy(getShowInEducationNews()) || isTruthy(getShowOnEducationHomepage())) {
      ArrayAppend(taxonomy, 'Education');
    }
    if (isTruthy(getShowInEngineeringNews()) || isTruthy(getShowOnEngineeringHomepage())) {
      ArrayAppend(taxonomy, 'Engineering');
    }
    if (isTruthy(getShowInLawNews()) || isTruthy(getShowOnLawHomepage())) {
      ArrayAppend(taxonomy, 'Law');
    }
    if (isTruthy(getShowInLiberalArtsNews()) || isTruthy(getShowOnLiberalArtsHomepage())) {
      ArrayAppend(taxonomy, 'Liberal Arts');
    }
    if (isTruthy(getShowInMedicineNews()) || isTruthy(getShowOnMedicineHomepage())) {
      ArrayAppend(taxonomy, 'Medicine');
    }
    if (isTruthy(getShowInMusicNews()) || isTruthy(getShowOnMusicHomepage())) {
      ArrayAppend(taxonomy, 'Music');
    }
    if (isTruthy(getShowInNursingNews()) || isTruthy(getShowOnNursingHomepage())) {
      ArrayAppend(taxonomy, 'Nursing');
    }
    if (isTruthy(getShowInPenfieldNews()) || isTruthy(getShowOnPenfieldHomepage())) {
      ArrayAppend(taxonomy, 'Penfield');
    }
    if (isTruthy(getShowInPharmacyNews()) || isTruthy(getShowOnPharmacyHomepage())) {
      ArrayAppend(taxonomy, 'Pharmacy');
    }
    if (isTruthy(getShowInTheologyNews()) || isTruthy(getShowOnTheologyHomepage())) {
      ArrayAppend(taxonomy, 'Theology');
    }
    if (isTruthy(getShowInWorkingAdultProgramsNews()) || isTruthy(getShowOnWorkingAdultProgramsHomepage())) {
      ArrayAppend(taxonomy, 'Working Adults');
    }

    return taxonomy;
  }

  public string function taxonomyList () {
    return ArrayToList(taxonomyArray());
  }

  public struct function toStruct () {
    return {
      // Standard custom element data
      pageID   = getPageID(),
      formID   = getFormID(),
      formName = getFormName(),
      // Custom elemement fields
      considerForUniversityHomepage      = getConsiderForUniversityHomepage(),
      contactEmail                       = getContactEmail(),
      contactName                        = getContactName(),
      contactPhone                       = getContactPhone(),
      content                            = getContent(),
      datePublished                      = getDatePublished(),
      lblBusiness                        = getLblBusiness(),
      lblEducation                       = getLblEducation(),
      lblEngineering                     = getLblEngineering(),
      lblLaw                             = getLblLaw(),
      lblLiberalArts                     = getLblLiberalArts(),
      lblMedicine                        = getLblMedicine(),
      lblMercerUniversity                = getLblMercerUniversity(),
      lblMusic                           = getLblMusic(),
      lblNews                            = getLblNews(),
      lblNursing                         = getLblNursing(),
      lblPenfield                        = getLblPenfield(),
      lblTheology                        = getLblTheology(),
      lblWorkingAdultPrograms            = getLblWorkingAdultPrograms(),
      showInBusinessNews                 = getShowInBusinessNews(),
      showInCHPNews                      = getShowInCHPNews(),
      showInEducationNews                = getShowInEducationNews(),
      showInEngineeringNews              = getShowInEngineeringNews(),
      showInLawNews                      = getShowInLawNews(),
      showInLiberalArtsNews              = getShowInLiberalArtsNews(),
      showInMedicineNews                 = getShowInMedicineNews(),
      showInMusicNews                    = getShowInMusicNews(),
      showInNursingNews                  = getShowInNursingNews(),
      showInPenfieldNews                 = getShowInPenfieldNews(),
      showInPharmacyNews                 = getShowInPharmacyNews(),
      showInTheologyNews                 = getShowInTheologyNews(),
      showInWorkingAdultProgramsNews     = getShowInWorkingAdultProgramsNews(),
      showOnBusinessHomepage             = getShowOnBusinessHomepage(),
      showOnCHPHomepage                  = getShowOnCHPHomepage(),
      showOnEducationHomepage            = getShowOnEducationHomepage(),
      showOnEngineeringHomepage          = getShowOnEngineeringHomepage(),
      showOnLawHomepage                  = getShowOnLawHomepage(),
      showOnLiberalArtsHomepage          = getShowOnLiberalArtsHomepage(),
      showOnMedicineHomepage             = getShowOnMedicineHomepage(),
      showOnMusicHomepage                = getShowOnMusicHomepage(),
      showOnNewsHomepage                 = getShowOnNewsHomepage(),
      showOnNursingHomepage              = getShowOnNursingHomepage(),
      showOnPenfieldHomepage             = getShowOnPenfieldHomepage(),
      showOnPharmacyHomepage             = getShowOnPharmacyHomepage(),
      showOnTheologyHomepage             = getShowOnTheologyHomepage(),
      showOnUniversityHomepage           = getShowOnUniversityHomepage(),
      showOnWorkingAdultProgramsHomepage = getShowOnWorkingAdultProgramsHomepage(),
      summary                            = getSummary(),
      summaryHeaderPhoto                 = getSummaryHeaderPhoto(),
      title                              = getTitle()
    };
  }

  // Tarteting the WP Import All plugin
  public struct function toStructForXMLExport () {
    return {
      content  = new FormattedTextBlock(getContent()).toStructForXMLExport(),
      summary  = encodeForXML(getSummary()),
      title    = encodeForXML(getTitle()),
      taxonomy = encodeForXML(taxonomyList())
    };
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  private boolean function isTruthy(v) {
    if (0 == ArrayLen(ARGUMENTS)) {
      return false;
    }
    if (!IsDefined('v')) {
      return false;
    }
    if (IsSimpleValue(v)) {
      if (IsNumeric(v)) {
        if (v <= 0) {
          return false;
        }
        return true;
      } else {
        if (0 == Len(v)) {
          return false;
        }
        return true;
      }
    }
    return true;
  }

  private void function setFromStruct (required struct s) {
    // Standard custom element data
    if (StructKeyExists(s, 'pageID')) {
      setPageID(s.pageID);
    }
    if (StructKeyExists(s, 'formID')) {
      setFormID(s.formID);
    }
    if (StructKeyExists(s, 'formName')) {
      setFormName(s.formName);
    }
    // Custom element fields
    if (StructKeyExists(s, 'considerForUniversityHomepage')) {
      if (IsNumeric(s.considerForUniversityHomepage)) {
        setConsiderForUniversityHomepage(s.considerForUniversityHomepage);
      }
    }
    if (StructKeyExists(s, 'contactEmail')) {
      setContactEmail(s.contactEmail);
    }
    if (StructKeyExists(s, 'contactName')) {
      setContactName(s.contactName);
    }
    if (StructKeyExists(s, 'contactPhone')) {
      setContactPhone(s.contactPhone);
    }
    if (StructKeyExists(s, 'content')) {
      setContent(s.content);
    }
    if (StructKeyExists(s, 'datePublished')) {
      setDatePublished(s.datePublished);
    }
    if (StructKeyExists(s, 'lblBusiness')) {
      setLblBusiness(s.lblBusiness);
    }
    if (StructKeyExists(s, 'lblEducation')) {
      setLblEducation(s.lblEducation);
    }
    if (StructKeyExists(s, 'lblEngineering')) {
      setLblEngineering(s.lblEngineering);
    }
    if (StructKeyExists(s, 'lblLaw')) {
      setLblLaw(s.lblLaw);
    }
    if (StructKeyExists(s, 'lblLiberalArts')) {
      setLblLiberalArts(s.lblLiberalArts);
    }
    if (StructKeyExists(s, 'lblMedicine')) {
      setLblMedicine(s.lblMedicine);
    }
    if (StructKeyExists(s, 'lblMercerUniversity')) {
      setLblMercerUniversity(s.lblMercerUniversity);
    }
    if (StructKeyExists(s, 'lblMusic')) {
      setlblMusic(s.lblMusic);
    }
    if (StructKeyExists(s, 'lblNews')) {
      setLblNews(s.lblNews);
    }
    if (StructKeyExists(s, 'lblNursing')) {
      setLblNursing(s.lblNursing);
    }
    if (StructKeyExists(s, 'lblPenfield')) {
      setLblPenfield(s.lblPenfield);
    }
    if (StructKeyExists(s, 'lblTheology')) {
      setLblTheology(s.lblTheology);
    }
    if (StructKeyExists(s, 'lblWorkingAdultPrograms')) {
      setLblWorkingAdultPrograms(s.lblWorkingAdultPrograms);
    }
    if (StructKeyExists(s, 'showInBusinessNews')) {
      if (IsNumeric(s.showInBusinessNews)) {
        setShowInBusinessNews(s.showInBusinessNews);
      }
    }
    if (StructKeyExists(s, 'showInCHPNews')) {
      if (IsNumeric(s.showInCHPNews)) {
        setShowInCHPNews(s.showInCHPNews);
      }
    }
    if (StructKeyExists(s, 'showInEducationNews')) {
      if (IsNumeric(s.showInEducationNews)) {
        setShowInEducationNews(s.showInEducationNews);
      }
    }
    if (StructKeyExists(s, 'showInEngineeringNews')) {
      if (IsNumeric(s.showInEngineeringNews)) {
        setShowInEngineeringNews(s.showInEngineeringNews);
      }
    }
    if (StructKeyExists(s, 'showInLawNews')) {
      if (IsNumeric(s.showInLawNews)) {
        setShowInLawNews(s.showInLawNews);
      }
    }
    if (StructKeyExists(s, 'showInLiberalArtsNews')) {
      if (IsNumeric(s.showInLiberalArtsNews)) {
        setShowInLiberalArtsNews(s.showInLiberalArtsNews);
      }
    }
    if (StructKeyExists(s, 'showInMedicineNews')) {
      if (IsNumeric(s.showInMedicineNews)) {
        setShowInMedicineNews(s.showInMedicineNews);
      }
    }
    if (StructKeyExists(s, 'showInMusicNews')) {
      if (IsNumeric(s.showInMusicNews)) {
        setShowInMusicNews(s.showInMusicNews);
      }
    }
    if (StructKeyExists(s, 'showInNursingNews')) {
      if (IsNumeric(s.showInNursingNews)) {
        setShowInNursingNews(s.showInNursingNews);
      }
    }
    if (StructKeyExists(s, 'showInPenfieldNews')) {
      if (IsNumeric(s.showInPenfieldNews)) {
        setShowInPenfieldNews(s.showInPenfieldNews);
      }
    }
    if (StructKeyExists(s, 'showInPharmacyNews')) {
      if (IsNumeric(s.showInPharmacyNews)) {
        setShowInPharmacyNews(s.showInPharmacyNews);
      }
    }
    if (StructKeyExists(s, 'showInTheologyNews')) {
      if (IsNumeric(s.showInTheologyNews)) {
        setShowInTheologyNews(s.showInTheologyNews);
      }
    }
    if (StructKeyExists(s, 'showInWorkingAdultProgramsNews')) {
      if (IsNumeric(s.showInWorkingAdultProgramsNews)) {
        setShowInWorkingAdultProgramsNews(s.showInWorkingAdultProgramsNews);
      }
    }
    if (StructKeyExists(s, 'showOnBusinessHomepage')) {
      if (IsNumeric(s.showOnBusinessHomepage)) {
        setShowOnBusinessHomepage(s.showOnBusinessHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnCHPHomepage')) {
      if (IsNumeric(s.showOnCHPHomepage)) {
        setShowOnCHPHomepage(s.showOnCHPHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnEducationHomepage')) {
      if (IsNumeric(s.showOnEducationHomepage)) {
        setShowOnEducationHomepage(s.showOnEducationHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnEngineeringHomepage')) {
      if (IsNumeric(s.showOnEngineeringHomepage)) {
        setShowOnEngineeringHomepage(s.showOnEngineeringHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnLawHomepage')) {
      if (IsNumeric(s.showOnLawHomepage)) {
        setShowOnLawHomepage(s.showOnLawHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnLiberalArtsHomepage')) {
      if (IsNumeric(s.showOnLiberalArtsHomepage)) {
        setShowOnLiberalArtsHomepage(s.showOnLiberalArtsHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnMedicineHomepage')) {
      if (IsNumeric(s.showOnMedicineHomepage)) {
        setShowOnMedicineHomepage(s.showOnMedicineHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnMusicHomepage')) {
      if (IsNumeric(s.showOnMusicHomepage)) {
        setShowOnMusicHomepage(s.showOnMusicHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnNewsHomepage')) {
      if (IsNumeric(s.showOnNewsHomepage)) {
        setShowOnNewsHomepage(s.showOnNewsHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnNursingHomepage')) {
      if (IsNumeric(s.showOnNursingHomepage)) {
        setShowOnNursingHomepage(s.showOnNursingHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnPenfieldHomepage')) {
      if (IsNumeric(s.showOnPenfieldHomepage)) {
        setShowOnPenfieldHomepage(s.showOnPenfieldHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnPharmacyHomepage')) {
      if (IsNumeric(s.showOnPharmacyHomepage)) {
        setShowOnPharmacyHomepage(s.showOnPharmacyHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnTheologyHomepage')) {
      if (IsNumeric(s.showOnTheologyHomepage)) {
        setShowOnTheologyHomepage(s.showOnTheologyHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnUniversityHomepage')) {
      if (IsNumeric(s.showOnUniversityHomepage)) {
        setShowOnUniversityHomepage(s.showOnUniversityHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnWorkingAdultProgramsHomepage')) {
      if (IsNumeric(s.showOnWorkingAdultProgramsHomepage)) {
        setShowOnWorkingAdultProgramsHomepage(s.showOnWorkingAdultProgramsHomepage);
      }
    }
    if (StructKeyExists(s, 'summary')) {
      setSummary(s.summary);
    }
    if (StructKeyExists(s, 'summaryHeaderPhoto')) {
      setSummaryHeaderPhoto(s.summaryHeaderPhoto);
    }
    if (StructKeyExists(s, 'title')) {
      setTitle(s.title);
    }
  }

}