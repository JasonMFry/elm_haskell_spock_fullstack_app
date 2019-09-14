module Msg exposing (Msg(..))

import Bootstrap.Dropdown as Dropdown
import Http
import Model


type Msg
    = NoOp
    | FetchPatients (Result Http.Error (List Model.Patient))
    | DropdownMsg Dropdown.State
