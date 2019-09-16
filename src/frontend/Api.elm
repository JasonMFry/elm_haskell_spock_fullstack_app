module Api exposing (getAllPatients, putPatient)

import Http
import Json.Decode as D
import Json.Encode as E
import Model
import Msg


putPatient : Model.Patient -> Cmd Msg.Msg
putPatient pt =
    -- curl -X PUT localhost:8080/patients/1 -H "Content-Type: application/json" -d '{ "name": "Bar", "note": "update the note", "seconds": 124}'
    -- {"result":"success","id":[]}
    Http.request
        { method = "PUT"
        , headers = []
        , url = "http://localhost:8080/patients/" ++ String.fromInt pt.patientId
        , body = Http.jsonBody <| patientEncoder pt

        -- I should listen for the response here but I'm keeping things simple
        , expect = Http.expectWhatever Msg.PutPatient
        , timeout = Nothing
        , tracker = Nothing
        }


getAllPatients : Cmd Msg.Msg
getAllPatients =
    Http.get
        { url = "http://localhost:8080/patients" -- shouldn't hardcode this in prod for sure.
        , expect = Http.expectJson Msg.FetchPatients (D.list patientDecoder)
        }


patientEncoder : Model.Patient -> E.Value
patientEncoder pt =
    E.object
        [ ( "name", E.string (Model.patientNameToString pt.patientName) )
        , ( "note", E.string pt.patientNote )
        , ( "seconds", E.int pt.patientSeconds )
        ]


patientDecoder : D.Decoder Model.Patient
patientDecoder =
    D.map4 Model.Patient
        (D.field "id" D.int)
        patientNameDecoder
        (D.field "note" D.string)
        (D.field "seconds" D.int)


patientNameDecoder : D.Decoder Model.PatientName
patientNameDecoder =
    D.map Model.PatientName (D.field "name" D.string)
