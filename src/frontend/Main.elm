module Main exposing (..)

import Api
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
    ( Model.Loading
    , Api.getAllPatients
    )



-- SUBS


subscriptions : Model.Model -> Sub Msg.Msg
subscriptions model =
    Sub.none
