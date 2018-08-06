# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Team.create(name: 'GOV.UK')
verify = Team.create(name: 'GOV.UK Verify')
Team.create(name: 'GOV.UK Pay')
Team.create(name: 'GOV.UK PaaS')
Team.create(name: 'RE Observe')

verify_escalation = ManualCalendar.create(
  name: 'Escalation',
  team: verify,
  clock_type: 'in_and_out_of_hours'
)

verify_primary = ManualCalendar.create(
  name: 'Primary',
  team: verify,
  clock_type: 'out_of_hours'
)

ManualCalendarEvent.create(
  manual_calendar: verify_escalation,
  emails: [
    'toby.lornewelch-richards@digital.cabinet-office.gov.uk',
  ],
  start_date: Date.today,
  end_date: Date.today + 7
)

ManualCalendarEvent.create(
  manual_calendar: verify_primary,
  emails: [
    'toby.lornewelch-richards@digital.cabinet-office.gov.uk',
  ],
  start_date: Date.today + 4,
  end_date: Date.today + 14
)
