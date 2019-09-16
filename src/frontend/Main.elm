module Main exposing (main)

import Api
import Bootstrap.Dropdown as Dropdown
import Browser
import Model
import Msg
import Time
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
      , timerState = Model.Stopped
      , secondsElapsed = Time.millisToPosix 0
      , resultTime = Time.millisToPosix 0
      }
    , Api.getAllPatients
    )



-- SUBS


subscriptions : Model.Model -> Sub Msg.Msg
subscriptions model =
    Sub.batch
        [ Dropdown.subscriptions model.dropdownState Msg.DropdownMsg
        , Time.every 1000 Msg.Tick
        ]
