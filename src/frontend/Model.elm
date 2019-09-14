-- TODO don't expose constructors


module Model exposing (Model, Patient, PatientName(..), patientNameToString)

import Bootstrap.Dropdown as Dropdown


type alias Model =
    { patients : List Patient
    , selectedPatient : Maybe Patient
    , dropdownState : Dropdown.State
    }



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
