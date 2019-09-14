module Main exposing (..)

import Browser
import Html
import Http
import Json.Decode as D
import Model
import View


main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


init : () -> ( Model, Cmd msg )
init _ =
    ( Loading
    , getAllPatients
    )



-- UPDATE


type Msg
    = NoOp
    | FetchPatients (Result Http.Error (List Patient))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        FetchPatients result ->
            case result of
                Ok pts ->
                    ( Success pts, Cmd.none )

                Err _ ->
                    -- Could add better error output here.
                    ( Failure, Cmd.none )



-- HTTP


getAllPatients : Cmd Msg
getAllPatients =
    Http.get
        { url = "http://localhost:8080/patients" -- shouldn't hardcode this in prod for sure.
        , expect = Http.expectJson FetchPatients (D.list patientDecoder)
        }


patientDecoder : D.Decoder Patient
patientDecoder =
    D.map4 Patient
        (D.field "id" D.int)
        patientNameDecoder
        (D.field "note" D.string)
        (D.field "seconds" D.int)


patientNameDecoder : D.Decoder PatientName
patientNameDecoder =
    D.map PatientName (D.field "name" D.string)



-- SUBS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
