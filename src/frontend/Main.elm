module Main exposing (..)

import Browser
import Html
import Http
import Json.Decode as D


main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



-- MODEL


type Model
    = Failure
    | Loading
    | Success (List Patient)



-- TODO improve type safety by making newtypes


type alias Patient =
    { patientId : Int
    , patientName : PatientName
    , patientNote : String
    , patientSeconds : Int
    }


type PatientName
    = PatientName String


patientNameToString : PatientName -> String
patientNameToString (PatientName s) =
    s


init : () -> ( Model, Cmd Msg )
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



-- VIEW


view : Model -> Html.Html Msg
view model =
    let
        output =
            case model of
                Failure ->
                    Html.text "Failure"

                Loading ->
                    Html.text "Loading"

                Success pts ->
                    renderPatients pts
    in
    Html.div [] [ output ]


renderPatients : List Patient -> Html.Html msg
renderPatients pts =
    -- TODO use dropdown to render names
    let
        maybePt =
            List.head pts
    in
    case maybePt of
        Just pt ->
            Html.div [] [ Html.text <| "Names: " ++ patientNameToString pt.patientName ]

        Nothing ->
            Html.div [] []



-- SUBS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
