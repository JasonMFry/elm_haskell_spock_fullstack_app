module View exposing (view)

import Html
import Model


view : Model.Model -> Html.Html msg
view model =
    let
        output =
            case model of
                Model.Failure ->
                    Html.text "Failure"

                Model.Loading ->
                    Html.text "Loading"

                Model.Success pts ->
                    renderPatients pts
    in
    Html.div [] [ output ]


renderPatients : List Model.Patient -> Html.Html msg
renderPatients pts =
    -- TODO use dropdown to render names
    let
        maybePt =
            List.head pts
    in
    case maybePt of
        Just pt ->
            Html.div [] [ Html.text <| "Names: " ++ Model.patientNameToString pt.patientName ]

        Nothing ->
            Html.div [] []
