-- TODO don't expose constructors


module Model exposing (Model, Patient, PatientName(..), TimerState(..), patientNameToString)

import Bootstrap.Dropdown as Dropdown
import String
import Time


type alias Model =
    { patients : List Patient
    , selectedPatient : Maybe Patient
    , dropdownState : Dropdown.State
    , timerState : TimerState
    , secondsElapsed : Time.Posix
    , resultTime : Time.Posix
    , showNewPatientForm : Bool
    , newPatientToAdd : Patient
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
    String.trim s


type TimerState
    = Stopped
    | Running
