module Msg exposing (Msg(..))

import Http
import Model


type Msg
    = NoOp
    | FetchPatients (Result Http.Error (List Model.Patient))
