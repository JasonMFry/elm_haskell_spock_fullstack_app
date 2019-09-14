module View exposing (view)

import Main


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
