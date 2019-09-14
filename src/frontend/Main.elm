module Main exposing (main)

import Api
import Bootstrap.Dropdown as Dropdown
import Browser
import Model
import Msg
import Update
import View


main : Program () Model.Model Msg.Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = Update.update
        , view = View.view
        }


init : () -> ( Model.Model, Cmd Msg.Msg )
init _ =
    ( { patients = []
      , selectedPatient = Nothing
      , dropdownState = Dropdown.initialState
      }
    , Api.getAllPatients
    )



-- SUBS


subscriptions : Model.Model -> Sub Msg.Msg
subscriptions model =
    Dropdown.subscriptions model.dropdownState Msg.DropdownMsg
