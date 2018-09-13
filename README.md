# [Who Is On Call](https://oncall.cloudapps.digital)

It might be you

---

## What this is

This is an app to aggregate all of the rotas that we have at GDS.

### Features:

- Aggregate calendars from PagerDuty
- Replacement for spreadsheet rotas (if PagerDuty is not required/superfluous)
- Annual leave tracking
- Automatically finds conflicts between annual leave and rotas

## What are the user needs

As someone who is supporting multiple services in-hours and/or out-of-hours I
need to know when I am expected to do so.

As someone who is organising a rota I need to know that the people on the rota
can find out when they are on it.

As someone who is organising a rota I need to know when the people on the rota
are taking leave so I can schedule the rota accordingly.

As someone who is working at GDS I need to know who is currently responsible
for supporting a service (both in-hours and out-of-hours) so I can contact the
correct person if there is a problem.

## How this works

This is a monolithic rails app with a postgres database.

It periodically pulls data from PagerDuty calendars and caches them.

It also manages `manual calendars` and `manual calendar events` which function
as a replacement for a spreadsheet rota.

The data that is stored:
- Email addresses and annual leave dates
- Email addresses and on-call dates (for manual calendars)
- PagerDuty calendar links (link to iCalendar) (for PagerDuty calendars)

Authentication is done via Google OAuth. With the exception of Icalendar
exports which are long salted URLs (they are supposed to be "public").

## How to run it locally
`./startup.sh`

## How to test it locally
`./pre-commit.sh`
