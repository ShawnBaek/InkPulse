# TravelCrumb product metrics

InkPulse should answer three questions at a glance:

1. Are people returning?
2. Are they reaching the core TravelCrumb behavior?
3. Is the app healthy enough for them to do it?

## Recommended primary screen

| Priority | Metric | Why it belongs on the device |
| --- | --- | --- |
| 1 | First-crumb conversion | Measures whether new users discover and complete the core behavior |
| 2 | D1 retention | Gives the earliest signal that the first experience is useful |
| 3 | D7 retention | Shows whether TravelCrumb is becoming a repeat habit |
| 4 | CRUMBS | Counts successful uses of the core behavior, not generic instrumentation traffic |
| 5 | USERS | Provides the total registered-account scale without duplicating retention |
| 6 | Crash-free users | Protects the overall experience and detects release-quality regressions |

The current product rendering uses this six-metric set.

### USERS

`USERS` is the total number of registered TravelCrumb accounts, read from the backend. It is intentionally not WAU: D1 and D7 already occupy the limited screen space used for engagement and retention signals.

## Exact definitions

### First-crumb conversion

```text
new users who create their first successful crumb within 24 hours
-----------------------------------------------------------------
all new users in the same acquisition cohort
```

This is a product activation metric. It is different from App Store conversion.

### App Store conversion

```text
downloads or redownloads
------------------------
unique App Store product-page views
```

Apple provides this metric in App Store Connect Analytics. It is useful for icon, screenshot, and acquisition work, but it does not show whether users find value after installation. It should appear on a separate acquisition page rather than replace first-crumb conversion on the primary product page.

### D1 and D7 retention

- `D1`: users acquired on day 0 who return on the next calendar day ÷ the day-0 cohort.
- `D7`: users acquired on day 0 who return on calendar day 7 ÷ the day-0 cohort.
- Use the GA4 property timezone and standard, non-rolling cohort calculation unless the implementation explicitly states otherwise.

### CRUMBS

Count only a successful persisted crumb. Do not increment the metric when the composer opens, validation fails, saving fails, or a duplicate analytics event is retried.

For a prototype, GA4 can count a single `crumb_created` event emitted after persistence succeeds. For production, a deduplicated backend count should be the source of truth.

### Crash-free users

```text
1 - (unique users with at least one fatal crash / all active users)
```

Show `CRASH-FREE` instead of raw crash rate so every percentage on the device has a consistent “higher is better” reading. Firebase notes that this metric covers fatal events and that an installation is counted as a user. The selected time range must stay visible or fixed because crash-free percentages are not directly comparable across different time windows.

Crash-free percentages are visible in Crashlytics. A custom device pipeline can calculate them from exported Firebase Sessions and Crashlytics data in BigQuery; the public Crashlytics API should not be assumed to expose the dashboard percentage directly.

## Useful secondary metrics

These are valuable, but the 400 × 300 primary screen should not show all of them at once.

### Product page

- Crumbs per weekly active user
- Percentage of users creating at least two crumbs in seven days
- D30 retention after enough cohort volume exists
- Budget created or completed, if budget usage is a strategic goal
- Photo, map, or currency feature adoption

### Reliability page

- Crash-free sessions by current release
- Sync success rate
- Crumb-save failure rate
- API error rate and p95 latency
- Latest-version adoption

### Acquisition page

- App Store product-page conversion
- First-time downloads
- Product-page views
- Source or campaign performance

## Implementation cautions

- Do not compare tiny cohorts without displaying the cohort size.
- Do not calculate conversion from raw event totals; deduplicate by user and successful outcome.
- Do not combine App Store conversion and first-crumb conversion under the same unlabeled definition.
- Keep a fixed seven-day window for CRUMBS and crash-free users on the primary screen; USERS remains an all-time registered total.
- Render the metric period or last-sync time when the real firmware UI is implemented.
