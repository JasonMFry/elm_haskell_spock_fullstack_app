module Update exposing (update)

import Model
import Msg


update : Msg.Msg -> Model.Model -> ( Model.Model, Cmd Msg.Msg )
update msg model =
    case msg of
        Msg.NoOp ->
            ( model, Cmd.none )

        Msg.FetchPatients result ->
            case result of
                Ok pts ->
                    ( { model | patients = pts }, Cmd.none )

                Err _ ->
                    -- Could add better error output here.
                    ( model, Cmd.none )

        Msg.DropdownMsg state ->
            ( { model | dropdownState = state }, Cmd.none )

        Msg.SelectedPatient pt ->
            ( { model | selectedPatient = Just pt }, Cmd.none )

        Msg.PatientNote note ->
            -- This isn't updating the list of patients, which means if the user switches to a different patient before submitting the form, the new info is wiped out.
            ( { model
                | selectedPatient =
                    Maybe.map (\p -> { p | patientNote = note }) model.selectedPatient
              }
            , Cmd.none
            )
