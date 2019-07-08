
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLanguage {
  final String name;
  final String languageCode;

  AppLanguage(this.name, this.languageCode);

  Locale get locale => Locale(languageCode);
}

class AppLocalizations {

  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static final supportedLanguages = [
    AppLanguage('English', 'en'), AppLanguage('Deutsch', 'de')
  ];

  static AppLanguage get defaultLanguage => supportedLanguages[0];

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // common
      'title': 'DW Ticket Point of Sale',
      'dialogYes': 'YES',
      'dialogNo': 'NO',
      'noTicketsSold': 'No Tickets sold',
      'settings': 'Settings',
      'settingsLanguage': 'Language',
      'settingsLanguageSelect': 'Select language',

      // event list
      'events': 'Events',
      'newEvent': 'New Event',
      'newEventHint': 'Create a new event in the current storage',
      'deleteEvent': 'Delete event',
      'deleteEventHint': 'Delete this event',
      'deleteEventMessage': 'Are you sure that you want to delete the selected event?',

      // event details
      'createEvent': 'Create new Event',
      'eventTitle': 'Event Title',
      'eventDate': 'Date',
      'eventTime': 'Time',
      'eventAvailableTickets': 'Available Tickets',

      // ticket list
      'tickets': 'Tickets',
      'newTicket': 'New Ticket',
      'newTicketHint': 'Create a new ticket in the current storage',
      'editTicketHint': 'Edit the details of this ticket',
      'deleteTicket': 'Delete ticket',
      'deleteTicketHint': 'Delete this ticket',
      'deleteTicketMessage': 'Are you sure that you want to delete the selected ticket?',

      // ticket details
      'editTicket': 'Edit Ticket',
      'editTicketCommit': 'Apply changes',
      'editTicketCommitHint': 'Apply the changes to the currently selected ticket',
      'createTicket': 'Create new Ticket',
      'createTicketCommit': 'Create new Ticket',
      'createTicketCommitHint': 'Create ticket with the given properties',
      'ticketTitle': 'Ticket title',
      'ticketPrice': 'Price',
      'ticketHasVirtualPrice': 'Has virtual price',
      'ticketVirtualPrice': 'Virtual price',

      // bookings
      'bookingsSummaryHint': 'Bookings summary',
      'bookingsListHint': 'Bookings list',
      'newBooking': 'New Booking',
      'newBookingHint': 'Create new ticket Booking',
      'deleteBooking': 'Delete Booking',
      'deleteBookingHint': 'Delete this booking',
      'deleteBookingMessage': 'Are you sure that you want do delete the selected booking?',
      'createBooking': 'Create new booking',
      'createBookingCommit': 'Create booking',
      'createBookingCommitHint': 'Apply the current ticket counts to a new booking',
      'createBookingAddOneTicket': 'Add one ticket',
      'createBookingRemoveOneTicket': 'Remove one ticket',
      'createBookingClearTickets': 'Clear tickets'
    },

    'de': {
      // common
      'title': 'DW Ticket-Verkaufspunkt',
      'dialogYes': 'JA',
      'dialogNo': 'NEIN',
      'noTicketsSold': 'Keine Tickets verkauft',
      'settings': 'Einstellungen',
      'settingsLanguage': 'Sprache',
      'settingsLanguageSelect': 'Sprache auswählen',

      // event list
      'events': 'Veranstaltungen',
      'newEvent': 'Neue Veranstaltung',
      'newEventHint': 'Erstellt eine neue Veranstaltung im lokalen Speicher',
      'deleteEvent': 'Veranstaltung löschen',
      'deleteEventHint': 'Diese Veranstaltung löschen',
      'deleteEventMessage': 'Sind Sie sicher, dass Sie die ausgewählte Veranstaltung löschen wollen?',

      // event details
      'createEvent': 'Neue Veranstaltung erstellen',
      'eventTitle': 'Veranstaltungstitel',
      'eventDate': 'Datum',
      'eventTime': 'Uhrzeit',
      'eventAvailableTickets': 'Verfügbare Tickets',

      // ticket list
      'tickets': 'Tickets',
      'newTicket': 'Neues Ticket',
      'newTicketHint': 'Erstellt ein neues Ticket im lokalen Speicher',
      'editTicketHint': 'Bearbeiten Sie die Details dieses Tickets',
      'deleteTicket': 'Ticket löschen',
      'deleteTicketHint': 'Dieses Ticket löschen',
      'deleteTicketMessage': 'Sind Sie sicher, dass Sie das ausgewählte Ticket löschen wollen?',

      // ticket details
      'editTicket': 'Ticket bearbeiten',
      'editTicketCommit': 'Änderungen übernehmen',
      'editTicketCommitHint': 'Übernehmen Sie die Änderungen am aktuellen Ticket dauerhaft',
      'createTicket': 'Neues Ticket erstellen',
      'createTicketCommit': 'Ticket erstellen',
      'createTicketCommitHint': 'Erzeugen Sie ein neues Ticket mit den gewählten Einstellungen',
      'ticketTitle': 'Ticket-Titel',
      'ticketPrice': 'Preis',
      'ticketHasVirtualPrice': 'Hat virtuellen Preis',
      'ticketVirtualPrice': 'Virtueller Preis',

      // bookings
      'bookingsSummaryHint': 'Buchungsübersicht',
      'bookingsListHint': 'Buchungsliste',
      'newBooking': 'Neue Buchung',
      'newBookingHint': 'Neue Ticketbuchung anlegen',
      'deleteBooking': 'Buchung löschen',
      'deleteBookingHint': 'Diese Buchung löschen',
      'deleteBookingMessage': 'Sind Sie sicher, dass Sie die ausgewählte Buchung löschen wollen?',
      'createBooking': 'Neue Buchung anlegen',
      'createBookingCommit': 'Buchung anlegen',
      'createBookingCommitHint': 'Legen Sie eine neue Buchung mit den gewählten Einstellungen an',
      'createBookingAddOneTicket': 'Add one ticket',
      'createBookingRemoveOneTicket': 'Remove one ticket',
      'createBookingClearTickets': 'Clear tickets'
    },
  };

  // common

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }

  String get dialogYes {
    return _localizedValues[locale.languageCode]['dialogYes'];
  }

  String get dialogNo {
    return _localizedValues[locale.languageCode]['dialogNo'];
  }

  String get noTicketsSold {
    return _localizedValues[locale.languageCode]['noTicketsSold'];
  }

  String get settings {
    return _localizedValues[locale.languageCode]['settings'];
  }

  String get settingsLanguage {
    return _localizedValues[locale.languageCode]['settingsLanguage'];
  }

  String get settingsLanguageSelect {
    return _localizedValues[locale.languageCode]['settingsLanguageSelect'];
  }

  // event list
  
  String get events {
    return _localizedValues[locale.languageCode]['events'];
  }

  String get newEvent {
    return _localizedValues[locale.languageCode]['newEvent'];
  }

  String get newEventHint {
    return _localizedValues[locale.languageCode]['newEventHint'];
  }

  String get deleteEvent {
    return _localizedValues[locale.languageCode]['deleteEvent'];
  }

  String get deleteEventHint {
    return _localizedValues[locale.languageCode]['deleteEventHint'];
  }

  String get deleteEventMessage {
    return _localizedValues[locale.languageCode]['deleteEventMessage'];
  }

  // event details

  String get createEvent {
    return _localizedValues[locale.languageCode]['createEvent'];
  }

  String get eventTitle {
    return _localizedValues[locale.languageCode]['eventTitle'];
  }

  String get eventDate {
    return _localizedValues[locale.languageCode]['eventDate'];
  }

  String get eventTime {
    return _localizedValues[locale.languageCode]['eventTime'];
  }

  String get eventAvailableTickets {
    return _localizedValues[locale.languageCode]['eventAvailableTickets'];
  }

  // ticket list

  String get tickets {
    return _localizedValues[locale.languageCode]['tickets'];
  }

  String get newTicket {
    return _localizedValues[locale.languageCode]['newTicket'];
  }

  String get newTicketHint {
    return _localizedValues[locale.languageCode]['newTicketHint'];
  }  

  String get editTicketHint {
    return _localizedValues[locale.languageCode]['editTicketHint'];
  }  

  String get deleteTicket {
    return _localizedValues[locale.languageCode]['deleteTicket'];
  }  

  String get deleteTicketHint {
    return _localizedValues[locale.languageCode]['deleteTicketHint'];
  }  

  String get deleteTicketMessage {
    return _localizedValues[locale.languageCode]['deleteTicketMessage'];
  }  

  // ticket details

  String get editTicket {
    return _localizedValues[locale.languageCode]['editTicket'];
  }  

  String get editTicketCommit {
    return _localizedValues[locale.languageCode]['editTicketCommit'];
  }  

  String get editTicketCommitHint {
    return _localizedValues[locale.languageCode]['editTicketCommitHint'];
  }  

  String get createTicket {
    return _localizedValues[locale.languageCode]['createTicket'];
  }  

  String get createTicketCommit {
    return _localizedValues[locale.languageCode]['createTicketCommit'];
  }  

  String get createTicketCommitHint {
    return _localizedValues[locale.languageCode]['createTicketCommitHint'];
  }  

  String get ticketTitle {
    return _localizedValues[locale.languageCode]['ticketTitle'];
  }  

  String get ticketPrice {
    return _localizedValues[locale.languageCode]['ticketPrice'];
  }  

  String get ticketHasVirtualPrice {
    return _localizedValues[locale.languageCode]['ticketHasVirtualPrice'];
  }  

  String get ticketVirtualPrice {
    return _localizedValues[locale.languageCode]['ticketVirtualPrice'];
  }  

  // bookings

  String get bookingsSummaryHint {
    return _localizedValues[locale.languageCode]['bookingsSummaryHint'];
  }  

  String get bookingsListHint {
    return _localizedValues[locale.languageCode]['bookingsListHint'];
  }  

  String get newBooking {
    return _localizedValues[locale.languageCode]['newBooking'];
  }  

  String get newBookingHint {
    return _localizedValues[locale.languageCode]['newBookingHint'];
  }  

  String get deleteBooking {
    return _localizedValues[locale.languageCode]['deleteBooking'];
  }  

  String get deleteBookingHint {
    return _localizedValues[locale.languageCode]['deleteBookingHint'];
  }  

  String get deleteBookingMessage {
    return _localizedValues[locale.languageCode]['deleteBookingMessage'];
  }  

  String get createBooking {
    return _localizedValues[locale.languageCode]['createBooking'];
  }  

  String get createBookingCommit {
    return _localizedValues[locale.languageCode]['createBookingCommit'];
  }  

  String get createBookingCommitHint {
    return _localizedValues[locale.languageCode]['createBookingCommitHint'];
  }

  String get createBookingAddOneTicket {
    return _localizedValues[locale.languageCode]['createBookingAddOneTicket'];
  }

  String get createBookingRemoveOneTicket {
    return _localizedValues[locale.languageCode]['createBookingRemoveOneTicket'];
  }

  String get createBookingClearTickets {
    return _localizedValues[locale.languageCode]['createBookingClearTickets'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLanguages.map(
      (language) => language.languageCode).contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture(AppLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}