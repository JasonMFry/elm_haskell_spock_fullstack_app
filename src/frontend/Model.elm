module Model exposing (..)


type Model
    = Failure
    | Loading
    | Success (List Patient)



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
