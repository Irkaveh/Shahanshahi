# شاهنشاهی (Shahanshahi)

یک بازی استراتژی تاریخی تحت وب درباره شکل‌گیری و تحول حکومت‌های ایرانی، با تمرکز اولیه بر ماد و مسیر تاریخی آن تا انتقال قدرت.

> **Project status:** active prototype / pre-release. The current game is playable, but architecture, historical documentation, balancing, and automated testing are still being developed.

## Why this project?

Shahanshahi is an open-source experiment in combining a historical timeline with a lightweight grand-strategy simulation that runs entirely in the browser.

The project intentionally favors a small, dependency-free web stack so that the prototype is easy to inspect, fork, modify, and run.

## Current features

- Interactive SVG map and province selection
- Army movement, attack, siege, split, merge, and recruitment
- Economy: taxation, trade, water, irrigation, administration, and science
- Diplomacy and regional-power relations
- Time-based Median historical events
- Court characters and influence
- Espionage network
- Secret royal ring and covert operations
- Browser save/load using localStorage
- Responsive layout for small screens
- No backend and no external runtime dependency

## Run locally

No build step is required.

Open `index.html` in a modern browser.

The game is also designed to be deployable as a static GitHub Pages site.

## Repository structure

- `index.html` — current playable prototype and main game logic
- `docs/HISTORICAL_MODEL.md` — scope and limitations of the historical simulation
- `docs/PLAYTEST.md` — manual smoke-test procedure
- `CHANGELOG.md` — project history and planned 0.1.0 release criteria
- `CONTRIBUTING.md` — contribution workflow
- `SECURITY.md` — security reporting policy
- `.github/workflows/` — automated validation and Pages deployment

## Roadmap

1. Separate historical data from simulation logic.
2. Split the large prototype file into maintainable modules.
3. Add automated tests for pure game systems such as economy, movement, combat, and save/load.
4. Improve balancing and document gameplay assumptions.
5. Add source-backed historical notes and scenario documentation.
6. Add more historical scenarios.
7. Improve accessibility and interface polish.
8. Publish a first tagged public release (0.1.0).

The repository contains GitHub Issues for the major roadmap items.

## Historical scope

The current scenario uses historical names and approximate dates but is a game abstraction, not a scholarly reconstruction. See `docs/HISTORICAL_MODEL.md` before treating a mechanic or event as a historical claim.

## Contributing

Bug reports, historical corrections, balance feedback, documentation improvements, and code contributions are welcome.

See `CONTRIBUTING.md` and the open Issues before making a large change.

## License

The project code is released under the MIT License. Third-party assets or data, if added later, may have separate licensing terms.
