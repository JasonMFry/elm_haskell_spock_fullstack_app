module Main exposing (..)

import Api
import Bootstrap.Dropdown as Dropdown
import Browser
import Html
import Http
import Json.Decode as D
import Model
import Msg
import Update
import View


main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = Update.update
        , view = View.view
        }


init : () -> ( Model.Model, Cmd Msg.Msg )
init _ =
    ( Model.Loading Dropdown.initialState
    , Api.getAllPatients
    )



-- SUBS


subscriptions : Model.Model -> Sub Msg.Msg
subscriptions model =
    Sub.none
