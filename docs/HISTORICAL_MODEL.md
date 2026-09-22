# Historical model

Shahanshahi is a historical strategy game, not a scholarly reconstruction.

The current prototype uses historical names, approximate dates, regional powers, and a simplified simulation model. Game mechanics may deliberately compress or abstract chronology, geography, institutions, military organization, and political causation.

## Current scope

The first playable scenario focuses on the Median period and the transition toward the Achaemenid period.

The code currently contains a simplified timeline around:
- the rise and consolidation of Median power;
- the decline of Assyria;
- the Median-Babylonian relationship;
- the Median-Lydian conflict;
- the late Median court;
- the rise of Cyrus II and the transition of power.

These elements are gameplay abstractions and should not be read as a claim that every event occurred exactly as represented by the simulation.

## Planned source layer

Historical claims should eventually be separated from gameplay data and documented with source notes. The intended source layer should prioritize:
1. Encyclopaedia Iranica and other academic reference works;
2. peer-reviewed historical scholarship;
3. primary-source translations where appropriate;
4. reputable museum and institutional material.

When a historical mechanic is intentionally simplified or disputed in scholarship, the documentation should say so rather than presenting the game model as settled fact.

## Important limitation

The current index.html contains both game logic and historical data. Separating historical data into versioned files is a roadmap item so that corrections can be made without rewriting gameplay code.
