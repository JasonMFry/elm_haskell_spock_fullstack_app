module Api exposing (getAllPatients)

import Http
import Json.Decode as D
import Model
import Msg


getAllPatients : Cmd Msg.Msg
getAllPatients =
    Http.get
        { url = "http://localhost:8080/patients" -- shouldn't hardcode this in prod for sure.
        , expect = Http.expectJson Msg.FetchPatients (D.list patientDecoder)
        }


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
