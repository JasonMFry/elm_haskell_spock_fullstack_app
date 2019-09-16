module Msg exposing (Msg(..))

import Bootstrap.Dropdown as Dropdown
import Http
import Model
import Time


type Msg
    = NoOp
    | FetchPatients (Result Http.Error (List Model.Patient))
    | PutPatient (Result Http.Error ())
    | DropdownMsg Dropdown.State
    | SelectedPatient Model.Patient
    | PatientNote String
    | SubmitForm Model.Patient
    | Tick Time.Posix
    | StartTimer
