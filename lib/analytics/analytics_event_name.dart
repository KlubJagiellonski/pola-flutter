
enum AnalyticsEventName {
  scanCode("scan_code"),
  companyReceived("company_received"),
  cardOpened("card_opened"),
  reportStarted("report_started"),
  reportFinished("report_finished"),
  menuItemOpened("menu_item_opened"),
  donateOpened("donate_opened"),
  aboutPola("about_pola"),
  polasFriends("polas_friends"),
  openGallery("open_gallery"),
  barcodeNotFoundOnPhoto("barcode_not_found_on_photo"),
  mainTabChanged("main_tab_changed"),
  searchOpened("search_opened");
 
  final String name;

  const AnalyticsEventName(this.name);
}
