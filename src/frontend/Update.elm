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
                    ( Model.Success pts, Cmd.none )

                Err _ ->
                    -- Could add better error output here.
                    ( Model.Failure, Cmd.none )
