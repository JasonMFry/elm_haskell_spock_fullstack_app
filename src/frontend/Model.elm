-- TODO don't expose constructors


module Model exposing (Model(..), Patient, PatientName(..), patientNameToString)

import Bootstrap.Dropdown as Dropdown


type Model
    = Failure
    | Loading
      -- I would need to add a dropdown to the Loading ADT to prevent FOOC. But I'm suspicious of this data structure so there's probably another, better option.
    | Success ( List Patient, Dropdown.State )



-- TODO improve type safety by making newtypes


type alias Patient =
    { patientId : Int
    , patientName : PatientName
    , patientNote : String
    , patientSeconds : Int
    }


type PatientName
    = PatientName String


patientNameToString : PatientName -> String
patientNameToString (PatientName s) =
    s
