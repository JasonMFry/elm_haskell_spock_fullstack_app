module Update exposing (update)

import Bootstrap.Dropdown as Dropdown
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
                    ( Model.Success ( pts, Dropdown.initialState ), Cmd.none )

                Err _ ->
                    -- Could add better error output here.
                    ( Model.Failure, Cmd.none )

        Msg.DropdownMsg state ->
            case model of
                Model.Success ( pts, _ ) ->
                    -- Having to use Model.Success here seems smelly, the data structure is probably sub-optimal.
                    ( Model.Success ( pts, state ), Cmd.none )

                _ ->
                    ( model, Cmd.none )
