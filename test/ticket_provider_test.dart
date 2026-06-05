import 'package:flutter_test/flutter_test.dart';
import 'package:event_hub/providers/ticket_provider.dart';

void main() {
  group('Ticket Provider Tests', () {
    test('Default tab should be 0', () {
      final provider = TicketProvider();

      expect(provider.selectedTab, 0);
    });

    test('Change tab works correctly', () {
      final provider = TicketProvider();

      provider.changeTab(1);

      expect(provider.selectedTab, 1);
    });

    test('Ticket does not exist initially', () {
      final provider = TicketProvider();

      expect(provider.hasTicket("Music Event"), false);
    });
  });
}