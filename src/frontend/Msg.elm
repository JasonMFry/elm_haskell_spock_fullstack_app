module Msg exposing (Msg(..))

import Bootstrap.Dropdown as Dropdown
import Http
import Model
import Time


type Msg
    = NoOp
    | FetchPatients (Result Http.Error (List Model.Patient))
    | SubmitUpdatePatientForm Model.Patient
    | PutPatient (Result Http.Error ())
    | SubmitNewPatientForm Model.Patient
    | PostPatient (Result Http.Error ())
    | NewPatientName String
    | DropdownMsg Dropdown.State
    | SelectedPatient Model.Patient
    | PatientNote String
    | Tick Time.Posix
    | StartTimer
    | StopTimer
    | IncrementTimer Time.Posix
    | ShowNewPatientForm
