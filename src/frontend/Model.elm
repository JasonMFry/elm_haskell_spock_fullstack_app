-- TODO don't expose constructors


module Model exposing (Model, Patient, PatientName(..), TimerState(..), patientNameToString)

import Bootstrap.Dropdown as Dropdown
import Time


type alias Model =
    { patients : List Patient
    , selectedPatient : Maybe Patient
    , dropdownState : Dropdown.State
    , timerState : TimerState
    , secondsElapsed : Time.Posix
    , startTime : Time.Posix
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


type TimerState
    = Stopped
    | Running
