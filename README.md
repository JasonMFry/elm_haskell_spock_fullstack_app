# Timed 10-meter Walk Feature

## Getting Started

1. Clone this repo and `cd` into the ten_meter_walk directory.
2. Follow [these instructions](https://docs.haskellstack.org/en/stable/README/)
   to install `stack`. Note that downloading stack and running the next command
   will likely take a long time.
3. Run `stack build --fast`
4. Run `stack exec ten-meter-walk`
5. Follow [these instructions](https://guide.elm-lang.org/install.html) to
   install `elm`.
6. Run `elm make src/frontend/Main.elm --output=elm.js`
7. Open index.html

## User Story

As a certified Prosthetist, I need to conduct the “Timed 10 Meter Walk Test” on
my patients and record the results in their medical record.  I want a simple
tool to help me conduct the test and keep track of the results for each
patient.

## Design Assumptions

I already know how to conduct the test, so the tool doesn’t need to focus on
teaching me about it. The tool doesn’t need any authentication or security
features. It needs to be easy to use and generate accurate output.  For each
test, it should save the times and a note to a data storage system.

## Known Issues

- ~~There is no way to add new patients through the UI.~~
- The database doesn't allow for storing multiple test results right now. There
  is no confirmation dialogue when editing test results, so accidentally
  overwriting notes and/or times is easy.
- The UI is ugly :)
- The app is very un-secure.
- The timer doesn't allow for anything more precise than seconds. I assumed
  that would be good enough for the code challenge.
