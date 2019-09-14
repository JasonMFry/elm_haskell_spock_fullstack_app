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
        , view = View.view Dropdown.initialState
        }


init : () -> ( Model.Model, Cmd Msg.Msg )
init _ =
    ( Model.Loading
    , Api.getAllPatients
    )



-- SUBS


subscriptions : Model.Model -> Sub Msg.Msg
subscriptions _ =
    Sub.none
