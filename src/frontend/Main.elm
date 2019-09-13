module Main exposing (..)

import Browser
import Html


main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


type alias Model =
    { patientId : Int
    , patientName : String
    , patientNote : String
    , patientSeconds : Int
    }


type Msg
    = NoOp


init : () -> ( Model, Cmd Msg )
init _ =
    ( { patientId = 0
      , patientName = ""
      , patientNote = ""
      , patientTime = 0
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : Model -> Html.Html Msg
view model =
    Html.div [] []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
